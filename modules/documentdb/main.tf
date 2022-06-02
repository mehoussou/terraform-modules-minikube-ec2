# Create a standard Document DB Cluster

resource "aws_docdb_cluster" "docdb" {
  cluster_identifier      = var.cluster-name
  engine                  = "docdb"
  master_username         = var.master-username
  master_password         = var.master-password
  backup_retention_period = var.retention-period
  preferred_backup_window = var.backup-window
  skip_final_snapshot     = var.skip-final-snapshot
}