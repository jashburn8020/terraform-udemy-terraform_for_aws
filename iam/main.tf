provider "aws" {
  region = "eu-west-2"
}

# Create a user so that we can attach a policy to the user
resource "aws_iam_user" "myUser" {
  name = "TJ"
}

resource "aws_iam_policy" "customPolicy" {
  name   = "GlacierEFSEC2"
  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "ec2:DeleteManagedPrefixList",
                "ec2:AuthorizeSecurityGroupIngress",
                "ec2:ReplaceRouteTableAssociation",
                "ec2:ModifyManagedPrefixList",
                "ec2:DeleteVpcEndpoints",
                "ec2:ResetInstanceAttribute",
                "ec2:ResetEbsDefaultKmsKeyId",
                "ec2:AttachInternetGateway",
                "ec2:ReportInstanceStatus",
                "ec2:DeleteVpnGateway",
                "ec2:CreateRoute",
                "elasticfilesystem:ClientMount",
                "glacier:PurchaseProvisionedCapacity",
                "ec2:UnassignPrivateIpAddresses",
                "ec2:CancelExportTask",
                "ec2:DeleteTransitGatewayPeeringAttachment",
                "ec2:ImportKeyPair",
                "ec2:AssociateClientVpnTargetNetwork",
                "ec2:StopInstances",
                "ec2:CreateVolume",
                "ec2:ReplaceNetworkAclAssociation",
                "ec2:CreateVpcEndpointServiceConfiguration",
                "ec2:CreateNetworkInterface",
                "ec2:CancelSpotInstanceRequests",
                "ec2:CreateTransitGatewayRoute",
                "ec2:CreateTransitGatewayVpcAttachment",
                "glacier:SetVaultNotifications",
                "glacier:CompleteMultipartUpload",
                "ec2:DeleteDhcpOptions",
                "ec2:DeleteNatGateway",
                "ec2:CancelCapacityReservation",
                "ec2:EnableTransitGatewayRouteTablePropagation",
                "glacier:ListVaults",
                "ec2:ModifyVpcEndpoint",
                "ec2:ModifyInstanceCapacityReservationAttributes",
                "ec2:CreateVpnConnection",
                "ec2:DeleteSpotDatafeedSubscription",
                "ec2:ImportVolume",
                "ec2:DeleteTransitGatewayPrefixListReference",
                "ec2:MoveAddressToVpc",
                "ec2:ModifyFleet",
                "ec2:RunScheduledInstances",
                "ec2:ModifyIdentityIdFormat",
                "ec2:CreateVpc",
                "ec2:RequestSpotFleet",
                "ec2:WithdrawByoipCidr",
                "ec2:ReleaseHosts",
                "ec2:DeleteTransitGatewayMulticastDomain",
                "ec2:ModifySubnetAttribute",
                "ec2:CreateSnapshot",
                "ec2:DeleteLaunchTemplateVersions",
                "ec2:DeleteNetworkAcl",
                "ec2:ModifyReservedInstances",
                "ec2:ReleaseAddress",
                "ec2:ModifyInstanceMetadataOptions",
                "ec2:AssociateDhcpOptions",
                "ec2:ModifyInstancePlacement",
                "ec2:CreateTrafficMirrorTarget",
                "ec2:ModifyTrafficMirrorFilterRule",
                "ec2:CreateClientVpnRoute",
                "ec2:AttachVpnGateway",
                "ec2:CreateLocalGatewayRoute",
                "ec2:ProvisionByoipCidr",
                "ec2:AssociateTransitGatewayMulticastDomain",
                "ec2:CreateVpnConnectionRoute",
                "ec2:ModifyVpnTunnelOptions",
                "ec2:DeleteVpcEndpointConnectionNotifications",
                "ec2:RestoreAddressToClassic",
                "ec2:DeleteCustomerGateway",
                "ec2:DeleteClientVpnRoute",
                "ec2:EnableVgwRoutePropagation",
                "ec2:ModifyVpcTenancy",
                "ec2:ApplySecurityGroupsToClientVpnTargetNetwork",
                "ec2:ConfirmProductInstance",
                "elasticfilesystem:DescribeMountTargetSecurityGroups",
                "elasticfilesystem:DescribeBackupPolicy",
                "ec2:DeleteSubnet",
                "ec2:EnableEbsEncryptionByDefault",
                "ec2:CreateImage",
                "ec2:PurchaseHostReservation",
                "ec2:CopyImage",
                "ec2:AssociateVpcCidrBlock",
                "ec2:ReplaceIamInstanceProfileAssociation",
                "ec2:DisassociateVpcCidrBlock",
                "ec2:CreateTransitGatewayPrefixListReference",
                "ec2:ModifyTrafficMirrorSession",
                "ec2:CreateCarrierGateway",
                "ec2:CreateTransitGatewayPeeringAttachment",
                "ec2:CreatePlacementGroup",
                "ec2:DeleteTransitGatewayVpcAttachment",
                "ec2:ReplaceNetworkAclEntry",
                "ec2:ModifyVpcPeeringConnectionOptions",
                "ec2:CreateTransitGatewayMulticastDomain",
                "ec2:AssociateTransitGatewayRouteTable",
                "ec2:ResetFpgaImageAttribute"
            ],
            "Resource": "*"
        }
    ]
}
EOF
}

# Attach the policy to the user.
resource "aws_iam_policy_attachment" "policyBind" {
  name       = "attachment"
  users      = [aws_iam_user.myUser.name]
  policy_arn = aws_iam_policy.customPolicy.arn
}
