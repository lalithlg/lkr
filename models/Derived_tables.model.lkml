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
