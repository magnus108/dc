<?php
function gavias_charityplus_preprocess_node__product(&$vars){

  $node = $vars['node'];
  $id = $node->id();
  $raised = 0; // Current price
  $funded = 0; // % funded
  $start = 0;
  $goal = 0;
  $prefix = '';
  $suffix = '';
  if($node->hasField('field_campaign_start')){
    $start = $node->field_campaign_start->value;
  }

  if($node->hasField('field_campaign_goal')){
    $goal = $node->field_campaign_goal->value;
    $instance = $node->getFieldDefinitions();
    $instance = $instance['field_campaign_goal'];
    $instance = $instance->getSettings();
    $suffix = $instance['suffix'];
    $prefix = $instance['prefix'];
  }

  $results = db_select('{uc_orders}', 'o');
  $results->leftJoin('{uc_order_products}', 'p', 'o.order_id = p.order_id');
  $results->fields('o', array('order_id', 'order_status'));
  $results->fields('p', array('nid', 'qty', 'price'));
  $results->condition(
    db_or()
      ->condition('o.order_status', 'payment_received', '=')
      ->condition('o.order_status', 'completed', '=')
  );
  $results->condition('p.nid', $id, '=');
  $orders = $results->execute()->fetchAll(PDO::FETCH_ASSOC);

  foreach ($orders as $order) {
    $raised = $raised + ($order['price'] * $order['qty']);
    //print($order['order_id'] . '--' . $order['price'] . '--' . $order['qty'] .'--'. ($order['price'] * $order['qty'])) .'::';
  }  

  $days_left = 0;
  if($node->hasField('field_campaign_time')){
    $now = date('Y-m-d');
    $time_end = $node->field_campaign_time->value;
    $days_left = round((strtotime($time_end) - strtotime($now)) / (60 * 60 * 24), 0);
  }
  if($days_left <= 0) {
    $days_left = t('expired');
   $vars['content']['add_to_cart'] = '<div class="expired">' . t('Expired Days left') . '</div>';
  }

  if($start) $raised = $raised + $start;
 
  if($goal > 0){
    $funded = round(($raised/$goal) * 100, 1);
  }
   $vars['funded_label'] = $funded;
  if($funded > 100) $funded = 100;

  $raised = $prefix . number_format($raised, 0, '.', ',') . $suffix;
  $vars['funded'] = $funded;
  $vars['raised'] = $raised;
  $vars['days_left'] = $days_left;
}