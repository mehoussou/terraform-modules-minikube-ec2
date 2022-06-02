variable cluster-name {
    description = "Name of Amazon DocumentDB Cluster"
}
variable "master-username" {
    description = "Amazon DocumentDB master username"
}
variable "master-password" {
    description = "Amazon DocumentDB master password, must be at least eight characters"
}
variable "retention-period" {
    description = "Amazon DocumentDB retention period integer in days"
}
variable "backup-window" {
    description = "Example 07:00-09:00"
}
variable "skip-final-snapshot" {
    description = "true or false"
}