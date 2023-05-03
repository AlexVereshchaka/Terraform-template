import boto3
import time

ec2_client = boto3.client('ec2')

def lambda_handler(event, context):
    # Check if this is the right alarm to trigger this function
    if event['Trigger']['Dimensions'][0]['value'] != 'my-nlb-target-group':
        return
    
    # Get the second instance from the auto scaling group
    asg_client = boto3.client('autoscaling')
    instances = asg_client.describe_auto_scaling_instances()
    instance_ids = [i['InstanceId'] for i in instances['AutoScalingInstances']]
    instance_ids.remove(event['Trigger']['Dimensions'][0]['value'])
    if not instance_ids:
        return
    
    # Deregister the second instance from the target group
    elbv2_client = boto3.client('elbv2')
    response = elbv2_client.deregister_targets(
        TargetGroupArn='arn:aws:elasticloadbalancing:us-east-1:123456789012:targetgroup/my-nlb-target-group/0fcf00840451de79',
        Targets=[
            {
                'Id': instance_ids[0],
            },
        ]
    )
    
    # Wait for 60 seconds before terminating the instance
    time.sleep(60)
    
    # Terminate the second instance
    response = ec2_client.terminate_instances(
        InstanceIds=[instance_ids[0]],
        DryRun=False
    )
