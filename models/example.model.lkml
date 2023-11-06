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

view: intloc_list_summary {
  derived_table: {
    sql: |
      SELECT
        act_date,
        SUM(subscriber_id) AS total_subscribers,
        COUNT(id) AS total_records
      FROM intloc_list
      GROUP BY act_date;
    }
  dimension_group: act_date {
    type: time
    timeframes: [raw, time, date, week, month, quarter, year]
    sql: ${TABLE}.act_date ;;
  }
  measure: total_subscribers {
    type: number
    sql: ${TABLE}.total_subscribers ;;
  }
  measure: total_records {
    type: count
    sql: ${TABLE}.total_records ;;
  }
}
