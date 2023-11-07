connection: "sfty-snowflake"

include: "/views/*.view.lkml"                # include all views in the views/ folder in this project
# include: "/**/*.view.lkml"                 # include all views in this project
# include: "my_dashboard.dashboard.lookml"   # include a LookML dashboard called my_dashboard

# # Select the views that should be a part of this model,
# # and define the joins that connect them together.
#
# explore: order_items {
#   join: orders {
#     relationship: many_to_one
#     sql_on: ${orders.id} = ${order_items.order_id} ;;
#   }
#
#   join: users {
#     relationship: many_to_one
#     sql_on: ${users.id} = ${orders.user_id} ;;
#   }
# }


explore: service_alert_daily_mdr_by_period {

  label: "service_alert_daily_mdr_by_period"

  join: service_alert_daily_mdr_today {
    type: left_outer
    sql_on: ${service_alert_daily_mdr_by_period.subscriber_id} = ${service_alert_daily_mdr_today.subscriber_id};;
    relationship: many_to_one
  }

  join:  service_alert_device_capture_int {

    type: left_outer
    sql_on: ${service_alert_daily_mdr_by_period.subscriber_id} = ${service_alert_device_capture_int.subscriber_id};;
    relationship: many_to_one

  }

}


view: new_DT_service_alert_daily_mdr_by_period {
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
      column: sum_transactions {}
      column: sigma_lbl {}
      }
    }
  }
