# IAM GROUP - Group for DevOps:
resource "aws_iam_group" "devops" {
  name = "devops"
  path = "/users/"
}


# IAM - User used for DevOps:
resource "aws_iam_user" "main" {
  for_each = toset(var.name)
  name = each.key
}

resource "aws_iam_group_membership" "main" {
    name = "devops"

    for_each = aws_iam_user.main
    users = each.value.name

}


#resource "aws_iam_access_key" "main" {
#  user = aws_iam_user.main.name
#}