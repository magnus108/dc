<?php 
namespace Drupal\gavias_blockbuilder\shortcodes;
if(!class_exists('gsc_icon_box')):
   class gsc_icon_box{

      public function render_form(){
         $fields = array(
            'type' => 'gsc_icon_box',
            'title' => ('Icon Box'), 
            'size' => 3,'fields' => array(
               array(
                  'id'        => 'title',
                  'type'      => 'text',
                  'title'     => t('Title'),
                  'class'     => 'display-admin'
               ),
               array(
                  'id'        => 'content',
                  'type'      => 'textarea',
                  'title'     => t('Content'),
                  'desc'      => t('Some Shortcodes and HTML tags allowed'),
               ),
               array(
                  'id'        => 'icon',
                  'type'      => 'text',
                  'title'     => t('Icon class'),
                  'std'       => '',
                  'desc'     => t('Use class icon font <a target="_blank" href="http://fontawesome.io/icons/">Icon Awesome</a>'),
               ),
               array(
                  'id'            => 'icon_position',
                  'type'          => 'select',
                  'options'       => array(
                     'top-center'      => 'Top Center',
                     'top-left'        => 'Top Left',
                     'top-right'       => 'Top Right',
                     'right'           => 'Right',
                     'left'            => 'Left',
                     'top-left-title'  => 'Top Left Title',
                     'top-right-title' => 'Top Right Title'
                  ),
                  'title'  => t('Icon Position'),
                  'std'    => 'top',
               ),
               array(
                  'id'        => 'min_height',
                  'type'      => 'text',
                  'title'     => t('Min Height'),
                  'desc'      => t('Set Min Height for icon box, e.g: 340px')
               ),
               array(
                  'id'        => 'link',
                  'type'      => 'text',
                  'title'     => t('Link'),
                  'desc'      => t('Link for text')
               ),
               array(
                  'id'        => 'bg_box',
                  'type'      => 'text',
                  'title'     => t('Background Box'),
                  'desc'      => t('Background for Box, e.g: #f5f5f5')
               ),
               array(
                  'id'        => 'skin_text',
                  'type'      => 'select',
                  'title'     => 'Skin Text for box',
                  'options'   => array(
                     'text-dark'  => t('Text Dark'), 
                     'text-light' => t('Text Light')
                  ) 
               ),
               array(
                  'id'        => 'target',
                  'type'      => 'select',
                  'options'   => array( 'on' => 'No', 'off' => 'Yes' ),
                  'title'     => t('Open in new window'),
                  'desc'      => t('Adds a target="_blank" attribute to the link.'),
               ),
               array(
                  'id'        => 'animate',
                  'type'      => 'select',
                  'title'     => t('Animation'),
                  'desc'      => t('Entrance animation for element'),
                  'options'   => gavias_blockbuilder_animate(),
               ), 
               array(
                  'id'     => 'el_class',
                  'type'      => 'text',
                  'title'  => t('Extra class name'),
                  'desc'      => t('Style particular content element differently - add a class name and refer to it in custom CSS.'),
               ),

            ),                                       
         );
         return $fields;
      }

      public function render_content( $item ) {
         if( ! key_exists('content', $item['fields']) ) $item['fields']['content'] = '';
         print self::sc_icon_box( $item['fields'], $item['fields']['content'] );
      }


      public static function sc_icon_box( $attr, $content = null ){
         extract(shortcode_atts(array(
            'title'           => '',
            'icon'            => '',
            'icon_color'      => '',
            'icon_position'   => 'top',
            'link'            => '',
            'skin_text'       => '',
            'target'          => '',
            'animate'         => '',
            'min_height'      => '',
            'el_class'        => '',
            'bg_box'          => ''
         ), $attr));


         // target
         if( $target ){
            $target = 'target="_blank"';
         } else {
            $target = false;
         }

         $class = array();
         if($el_class){ $class[] = $el_class; }
         $class[] = $icon_position;
         if($skin_text){$class[] = $skin_text;}

         $style = array();
         $style_icon = '';
         if(isset($min_height) && $min_height){
            $style[] = "min-height:{$min_height};";
         }

         if(isset($bg_box) && $bg_box){
            $style[] = "background-color: {$bg_box};";
            if($icon_position == 'top-center'){
               $style_icon = "style=\"border-color:{$bg_box};color:{$bg_box};\"";
            }
            $class[] = 'has-background';
         }

         if($animate){
            $class[] = 'wow';
            $class[] = $animate;
         }

         ?>
         <?php ob_start() ?>
         <div class="widget gsc-icon-box <?php if(count($class)>0) print implode($class, ' ') ?>" <?php if(count($style) > 0) print 'style="'.implode($style, ';').'"' ?>>
            <?php if($icon){ ?><div class="highlight-icon" <?php print $style_icon ?>><span class="icon <?php print $icon ?>"></span></div><?php }?>

            <div class="highlight_content">
               <?php if($link){ ?> <a href="<?php echo $link ?>"> <?php } ?>
                  <h4><?php print $title; ?></h4>
               <?php if($link){ ?> </a> <?php } ?>
               <?php if($content){ ?>
                  <div class="desc"><?php print do_shortcode($content); ?></div>
               <?php } ?>   
            </div>

         </div> 
         <?php return ob_get_clean() ?>
       <?php
      }

      public function load_shortcode(){
         add_shortcode( 'icon_box', array($this, 'sc_icon_box') );
      }
   } 
endif;   
