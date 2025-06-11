locals {
  instance_types = tomap({
    small = {
      database   = "db.r7g.large"
      kubernetes = "r7i.xlarge"
      redis      = "cache.m6g.large"
    }
    medium = {
      database   = "db.r7g.2xlarge"
      kubernetes = "r7i.2xlarge"
      redis      = "cache.m6g.xlarge"
    }
  })
}