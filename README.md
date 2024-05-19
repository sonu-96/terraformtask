# terraformtask
## ADD cred.tf file for aws credentials
---
variable "access_key" {
  type = string
  default = ""
  description = "IAM user access_id"
}

variable "secret_key" {
  type = string
  default = ""
  description = "IAM user secret_id"
}

---
