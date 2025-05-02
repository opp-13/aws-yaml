#! /bin/bash

VPC_STACK="eks-vpc-stack"

# Stack outputs 가져오기
outputs=$(aws cloudformation describe-stacks --stack-name $VPC_STACK --query "Stacks[0].Outputs" --output json)

# 개별 값 추출
export VPC_ID=$(echo $outputs | jq -r '.[] | select(.OutputKey=="VPCId").OutputValue')
export PRIVATE_SUBNET_1_ID=$(echo $outputs | jq -r '.[] | select(.OutputKey=="PrivateSubnet1Id").OutputValue')
export PRIVATE_SUBNET_2_ID=$(echo $outputs | jq -r '.[] | select(.OutputKey=="PrivateSubnet2Id").OutputValue')
export PRIVATE_DB_SUBNET_1_ID=$(echo $outputs | jq -r '.[] | select(.OutputKey=="PrivateSubnetDB1Id").OutputValue')
export PRIVATE_DB_SUBNET_2_ID=$(echo $outputs | jq -r '.[] | select(.OutputKey=="PrivateSubnetDB2Id").OutputValue')

# 결과 출력
echo "VPC_STACK: $VPC_STACK"
echo "VPC_ID: $VPC_ID"
echo "PRIVATE_SUBNET_1_ID (AZ-a): $PRIVATE_SUBNET_1_ID"
echo "PRIVATE_SUBNET_2_ID (AZ-c): $PRIVATE_SUBNET_2_ID"
echo "PRIVATE_DB_SUBNET_1_ID (AZ-d): $PRIVATE_DB_SUBNET_1_ID"
echo "PRIVATE_DB_SUBNET_2_ID (AZ-d): $PRIVATE_DB_SUBNET_2_ID"

envsubst < eks-prac1.yaml > eks-prac-env-add.yaml