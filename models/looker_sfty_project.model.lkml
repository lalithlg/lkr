connection: "sfty-snowflake"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: looker_sfty_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_sfty_project_default_datagroup

explore: service_alert_device_capture_int {
  label: "derived table"
  join: device_capture_summary {
    type: left_outer
    sql_on: ${service_alert_device_capture_int.subscriber_id} = ${device_capture_summary.subscriber_id};;
    relationship: many_to_one
  }
}
