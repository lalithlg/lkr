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

explore:  service_alert_daily_mdr_by_period{
  hidden: no
}



explore: new_dt_sample {

  hidden: no

}
explore: service_alert_daily_mdr_today {
  hidden: no
}
explore: new_dt_service_alert_daily_mdr_today {
  hidden: no
}

explore: new_sql_dt_from__service_alert_new_intloc {
  hidden: no
}
 explore: sql_dt_using_joins  {hidden:no}
