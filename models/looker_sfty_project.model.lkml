connection: "sfty-snowflake"

# include all the views
include: "/views/**/*.view.lkml"

datagroup: looker_sfty_project_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}

persist_with: looker_sfty_project_default_datagroup

explore: intloc_list {}

explore: new_intloc_list {}

#explore: new_sub_list {}

explore: service_alert_daily_mdr_by_period {}

explore: service_alert_daily_mdr_by_period_int {}

explore: service_alert_daily_mdr_today {}

explore: service_alert_daily_mdr_today_int {}

explore: service_alert_daily_mdr_txn {}

explore: service_alert_daily_mdr_txn_int {}

explore: service_alert_device_capture {}

explore: service_alert_device_capture_int {}

explore: service_alert_new_first_party {}

explore: service_alert_new_intloc {}

explore: sub_list {}

explore: new_sub_list {
  label:"combinedsublist"
  description: "Explore based on the service_alert_device_capture view."

  join: service_alert_new_first_party {
    relationship: many_to_one
    sql_on: ${service_alert_new_first_party.subscriber_id} = ${new_sub_list.subscriber_id} ;;
  }


}
