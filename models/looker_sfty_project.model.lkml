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

explore: new_sub_list {}

explore: service_alert_daily_mdr_by_period {}

explore: service_alert_daily_mdr_by_period_int {}

explore: service_alert_daily_mdr_today {}

explore: service_alert_daily_mdr_today_int {}

explore: service_alert_daily_mdr_txn {}

explore: service_alert_daily_mdr_txn_int {}

explore: service_alert_device_capture {}

explore: service_alert_device_capture2 {
#  join: service_alert_daily_mdr_today_int {
#    type: left_outer
#    relationship: one_to_many
#  }
hidden: no
extends: [service_alert_device_capture]
}

  view: service_alert_device_capture2 {
    derived_table: {
      explore_source: service_alert_daily_mdr_by_period {
        column: subscriber_id {}
        column: sub_name {}

        column: act_date_date {}
        column: avg_txn {}
        column: stdd_txn {}
        column: avg_txn_device {}
        column: avg_txn_device_fp {}
        column: avg_txn_device_tp {}
        column: stdd_txn_device {}
        column: stdd_txn_device_fp {}
        column: stdd_txn_device_tp {}
        column: week_cnt {}

      }
    }


}

explore: service_alert_device_capture_int {}

explore: service_alert_new_first_party {}

explore: service_alert_new_intloc {}

explore: sub_list {}
