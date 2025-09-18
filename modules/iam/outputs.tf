output "service_account_roles_arns" {
  description = "Service account role ARNs"
  value = merge({
    api-srv       = module.api_srv_iam_role.iam_role_arn
    migration-job = module.migration_job_iam_role.iam_role_arn
    scheduler-srv = module.scheduler_srv_iam_role.iam_role_arn
    ui-srv        = module.ui_srv_iam_role.iam_role_arn
    worker-srv    = module.worker_srv_iam_role.iam_role_arn
    },
    var.flower_enabled ? {
      flower-srv = module.flower_srv_iam_role[0].iam_role_arn
    } : {}
  )
}