resource "aws_cloudformation_stack" "dedicated_hosts" {
  name = var.cf_stack_name

  template_body = <<STACK
{
  "Resources" : {
    "MyDedicatedHost": {
      "Type" : "AWS::EC2::Host",
      "Properties" : {
          "AutoPlacement" : "${var.auto_placement}",
          "AvailabilityZone" : "${var.availability_zone}",
          "HostRecovery" : "${var.host_recovery}",
          "InstanceType" : "${var.instance_type}"
        }
    }
  },
  "Outputs" : {
    "HostID" : {
      "Description": "Host ID",  
      "Value" : { "Ref" : "MyDedicatedHost" }
    }
  }
}
STACK
}
