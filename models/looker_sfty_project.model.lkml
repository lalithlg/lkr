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

#explore: service_alert_device_capture_int {}

explore: service_alert_new_first_party {}

explore: sub_list {}

explore: service_alert_device_capture_int {
  hidden: no
  extends: [service_alert_device_capture]
  sql_always_where: ${is_alert_raised} ;;

  join: today {
    from: service_alert_daily_mdr_today_int
    type: left_outer
    relationship: one_to_one
    sql_on: ${service_alert_device_capture_int.subscriber_id} = ${today.subscriber_id}
                      AND ${service_alert_device_capture_int.integration_point_name} = ${today.integration_point_name}
                      AND ${service_alert_device_capture_int.act_date} = ${today.service_datetime_raw};;
  }

  join: service_alert_new_intloc {
    from: service_alert_new_intloc
    type: inner
    relationship: one_to_one
    sql_on: ${service_alert_device_capture_int.subscriber_id} = ${service_alert_new_intloc.subscriber_id};;
  }
}

view: service_alert_device_capture_int3 {
  derived_table: {
    explore_source: service_alert_device_capture
    sql: |
      SELECT
        subscriber_id,
        sub_name,
        integration_point_name,
        act_date_date,
        avg_txn,
        stdd_txn,
        avg_txn_device,
        stdd_txn_device,
        week_cnt
      FROM service_alert_device_capture
      WHERE is_alert_raised = 'Yes';

      }
      parameter: p_deviation {
      type: string
      default_value: "-5"
      }

      parameter: p_min_txn  {
      type: number
      default_value: "100"
      }

      dimension: subscriber_id {
      label: "Subscriber Code"
      type: number
      value_format_name: id
      }

      dimension: sub_name {
      label: "Subscriber Name"
      type: string
      sql: ${TABLE}.sub_name ;;
  }

  dimension: integration_point_name {
    label: "Integration point"
    type: string
    sql: ${TABLE}.integration_point_name ;;
  }

  dimension_group: act_date {
    hidden: yes
    type: time
    timeframes: [raw, date]
    sql: ${TABLE}.act_date_date ;;
  }

  dimension: service_time {
    type: string
    sql: to_char(${act_date_raw}, 'YYYY-MM-DD') ;;
  }

  dimension: avg_txn {
    label: "Historical Txn Avg"
    type: number
    value_format_name: decimal_0
  }

  dimension: avg_txn_device {
    hidden: yes
    type: number
  }
}
