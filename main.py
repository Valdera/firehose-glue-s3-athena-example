import boto3
import json
from datetime import datetime

firehose_client = boto3.client('firehose', region_name='ap-southeast-3')

def send_batch_events(events):
    """Send multiple events in a single API call"""

    records = []
    for event in events:
        records.append({
            'Data': json.dumps(event) + '\n'
        })

    response = firehose_client.put_record_batch(
        DeliveryStreamName='user-events-stream',
        Records=records
    )

    return response

if __name__ == "__main__":
    sample_events = [
        {
            'user_id': 'user_12345',
            'event_type': 'page_view',
            'page_url': '/products/laptop',
            'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'device_type': 'desktop',
            'browser': 'chrome',
            'country': 'US'
        },
        {
            'user_id': 'user_67890',
            'event_type': 'click',
            'page_url': '/checkout',
            'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'device_type': 'mobile',
            'browser': 'safari',
            'country': 'ID'
        },
        {
            'user_id': 'user_11111',
            'event_type': 'purchase',
            'page_url': '/confirmation',
            'timestamp': datetime.now().strftime('%Y-%m-%d %H:%M:%S'),
            'device_type': 'tablet',
            'browser': 'firefox',
            'country': 'SG'
        }
    ]

    response = send_batch_events(sample_events)
    print(f"Successfully sent {len(sample_events)} events to Firehose")
    print(f"Response: {response}")
