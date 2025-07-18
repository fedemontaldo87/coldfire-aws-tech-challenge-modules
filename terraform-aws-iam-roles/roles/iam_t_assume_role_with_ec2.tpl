{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": ${trusted_services},
        "AWS": ${trusted_roles}
      },
      "Action": "sts:AssumeRole"
      %{ if external_id != "" }
      ,
      "Condition": {
        "StringEquals": {
          "sts:ExternalId": "${external_id}"
        }
      }
      %{ endif }
    }
  ]
}