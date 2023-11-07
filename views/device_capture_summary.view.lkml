# If necessary, uncomment the line below to include explore_source.

# include: "looker_sfty_project.model.lkml"

view: device_capture_summary {
  derived_table: {
    explore_source: service_alert_device_capture_int {
      column: avg_txn {}
      column: subscriber_id {}
      column: count {}
      derived_column: sum_device_rate {sql: avg_txn / subscriber_id;;}
      filters: {
        field: service_alert_device_capture_int.subscriber_id
        value: ""
      }
      filters: {
        field: service_alert_device_capture_int.count
        value: ""
      }
      filters: {
        field: service_alert_device_capture_int.avg_txn
        value: ""
      }
    }
  }
  dimension: avg_txn {
    description: ""
    type: number
  }
  dimension: subscriber_id {
    description: ""
    type: number
  }
  dimension: count {
    description: ""
    type: number
  }
}
