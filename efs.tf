resource "aws_efs_file_system" "loki_efs" {
  tags = {
    Name = "loki-efs"
  }
}

resource "aws_efs_mount_target" "mount" {
  file_system_id = aws_efs_file_system.loki_efs.id
  subnet_id      = "subnet-0a1d10d93df720021"
  security_groups = [aws_security_group.efs_security_group.id]
}

resource "aws_efs_mount_target" "mount2" {
  file_system_id = aws_efs_file_system.loki_efs.id
  subnet_id      = "subnet-0507b04a3d8fb2da1"
  security_groups =  [aws_security_group.efs_security_group.id]
}

resource "aws_efs_access_point" "ubuntu_user_access" {
  file_system_id = aws_efs_file_system.loki_efs.id
  posix_user {
    gid = 1001 # for amundsen, important that same gui/uid used across each access point
    uid = 1001
  }
  root_directory {
    path = "/"
    creation_info {
      owner_gid   = 1001
      owner_uid   = 1001
      permissions = 755
    }
  }
}