#!/usr/bin/env python3
"""Build and upload version.json to Tencent Cloud COS.

- Downloads existing version.json from COS to get releases history
- Prepends current version to releases array
- Sets version/downloadUrl to latest version info
- Uploads back to COS
"""
import argparse
import json
import os
import tempfile

from qcloud_cos import CosConfig, CosS3Client


def build_version_json(channel, version, date, body, domain):
    """Build version.json content."""
    download_url = f"https://{domain}/{channel}/{version}/AFA.exe"

    current_release = {
        "tag_name": version,
        "body": body,
        "date": date,
    }

    return {
        "version": version,
        "downloadUrl": download_url,
        "date": date,
        "body": body,
        "releases": [current_release],
    }


def get_cos_client():
    """Create COS client from environment variables."""
    config = CosConfig(
        Region=os.environ["COS_REGION"],
        SecretId=os.environ["COS_SECRET_ID"],
        SecretKey=os.environ["COS_SECRET_KEY"],
    )
    return CosS3Client(config)


def download_existing_releases(cos_client, bucket, channel):
    """Download existing releases array from COS. Returns empty list on failure."""
    key = f"{channel}/version.json"
    try:
        with tempfile.NamedTemporaryFile(suffix=".json", delete=False) as f:
            tmp_path = f.name
        cos_client.download_file(
            Bucket=bucket,
            Key=key,
            DestFilePath=tmp_path,
        )
        with open(tmp_path, "r", encoding="utf-8") as f:
            data = json.load(f)
        os.unlink(tmp_path)
        return data.get("releases", [])
    except Exception:
        return []


def upload_version_json(cos_client, bucket, channel, data):
    """Upload version.json to COS."""
    key = f"{channel}/version.json"
    with tempfile.NamedTemporaryFile(
        mode="w", suffix=".json", encoding="utf-8", delete=False
    ) as f:
        json.dump(data, f, ensure_ascii=False, indent=2)
        tmp_path = f.name
    cos_client.upload_file(
        Bucket=bucket,
        Key=key,
        LocalFilePath=tmp_path,
    )
    os.unlink(tmp_path)
    print(f"Uploaded {key}")


def main():
    parser = argparse.ArgumentParser(description="Build and upload version.json")
    parser.add_argument("--channel", required=True, choices=["stable", "beta"])
    parser.add_argument("--version", required=True)
    parser.add_argument("--date", required=True)
    parser.add_argument(
        "--body",
        default="",
        help="Release body text (use --body-file to read from file, preferred for safety)",
    )
    parser.add_argument(
        "--body-file",
        default=None,
        help="Path to file containing release body (safer than --body for special characters)",
    )
    parser.add_argument("--domain", required=True)
    args = parser.parse_args()

    # Read body from file if --body-file is provided, otherwise use --body directly
    if args.body_file:
        with open(args.body_file, "r", encoding="utf-8") as f:
            body = f.read()
    else:
        body = args.body

    data = build_version_json(args.channel, args.version, args.date, body, args.domain)

    cos_client = get_cos_client()
    bucket = os.environ["COS_BUCKET"]
    existing_releases = download_existing_releases(cos_client, bucket, args.channel)

    existing_versions = {r["tag_name"] for r in existing_releases}
    if args.version not in existing_versions:
        data["releases"].extend(existing_releases)

    upload_version_json(cos_client, bucket, args.channel, data)
    print(f"version.json updated: {args.version} ({args.channel})")


if __name__ == "__main__":
    main()
