<?php

namespace Drupal\magnus_rest\Plugin\views\style;

use Drupal\Core\Cache\CacheableDependencyInterface;
use Drupal\rest\Plugin\views\style\Serializer;

/**
 * The style plugin for serialized output formats.
 *
 * Add separator in csv file so Microsoft Word knows how to open it.
 *
 * @ingroup views_style_plugins
 *
 * @ViewsStyle(
 *   id = "single_serializer",
 *   title = @Translation("Single Serializer"),
 *   help = @Translation("Serializes views row data using the Serializer component."),
 *   display_types = {"data"}
 * )
 */
class SingleSerializer extends Serializer implements CacheableDependencyInterface {

  /**
   * {@inheritdoc}
   */
  public function render() {
    $rows = array();

    foreach ($this->view->result as $row_index => $row) {
      $this->view->row_index = $row_index;
      $rows[] = $this->view->rowPlugin->render($row);
    }
    unset($this->view->row_index);

    if ((empty($this->view->live_preview))) {
      $content_type = $this->displayHandler->getContentType();
    }
    else {
      $content_type = !empty($this->options['formats']) ? reset($this->options['formats']) : 'json';
    }

    if (count($rows) == 1){
      return $this->serializer->serialize($rows[0], $content_type);
    } else {
      return $this->serializer->serialize($rows, $content_type);
    }
  }

}
