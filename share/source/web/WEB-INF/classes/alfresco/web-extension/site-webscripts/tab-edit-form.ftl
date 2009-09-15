<#import "/org/alfresco/components/form/form.lib.ftl" as formLib />

<!-- Dependency files for Tabview -->
<link rel="stylesheet" type="text/css" href="${url.context}/yui/tabview/assets/skins/sam/tabview.css">
<script type="text/javascript" src="${url.context}/yui/yahoo-dom-event/yahoo-dom-event.js"></script>
<script type="text/javascript" src="${url.context}/yui/element/element-min.js"></script>
<script type="text/javascript" src="${url.context}/yui/connection/connection-min.js"></script>
<script type="text/javascript" src="${url.context}/yui/tabview/tabview-min.js"></script>

<!-- Dependency files for Accordion Appearance -->
<link rel="stylesheet" type="text/css" href="${url.context}/yui/container/assets/skins/sam/container.css" />
<link rel="stylesheet" type="text/css" href="${url.context}/js/bubbling-2.1/accordion/assets/accordion.css" />
<style type="text/css">
.myAccordion {
  float: left;
  margin-right: 15px;
}
  .myAccordion .yui-cms-accordion .yui-cms-item {
    width: 200px;
  }
</style>
<script type="text/javascript" src="${url.context}/yui/utilities/utilities.js"></script>
<script type="text/javascript" src="${url.context}/js/bubbling.v2.1-min.js"></script>
<script type="text/javascript" src="${url.context}/js/bubbling-2.1/accordion/accordion.js"></script>

<!-- Dependency files for WYSIWYG control -->
<script type="text/javascript" src="${page.url.context}/modules/editors/tiny_mce/tiny_mce.js"></script>
<script type="text/javascript" src="${page.url.context}/modules/editors/tiny_mce-min.js"></script>

<!-- Dependency files for Auto Complete control -->
<link rel="stylesheet" type="text/css" href="${url.context}/yui/fonts/fonts-min.css" />
<link rel="stylesheet" type="text/css" href="${url.context}/yui/autocomplete/assets/skins/sam/autocomplete.css" />
<!--
<script type="text/javascript" src="${url.context}/yui/yahoo-dom-event/yahoo-dom-event.js"></script>
-->
<script type="text/javascript" src="${url.context}/yui/connection-min.js"></script>
<script type="text/javascript" src="${url.context}/yui/animation/animation-min.js"></script>
<script type="text/javascript" src="${url.context}/yui/datasource/datasource-min.js"></script>
<script type="text/javascript" src="${url.context}/yui/autocomplete/autocomplete-min.js"></script>

<!-- Dependency files for Cascade Select control -->
<!--
<script type="text/javascript" src="${url.context}/yui/yahoo-dom-event/yahoo-dom-event.js"></script>
<script type="text/javascript" src="${url.context}/yui/connection/connection-min.js"></script>
-->
<script type="text/javascript" src="${url.context}/yui/yahoo/yahoo-min.js" ></script> 
<script type="text/javascript" src="${url.context}/yui/event/event-min.js" ></script> 


<#if error?exists>
   <div class="error">${error}</div>
<#elseif form?exists>

   <#assign formId=args.htmlid + "-form">
   <#assign formUI><#if args.formUI??>${args.formUI}<#else>true</#if></#assign>

   <#if formUI == "true">
      <@formLib.renderFormsRuntime formId=formId />
   </#if>
   
   <div id="${formId}-container" class="form-container">
      
      <#if form.showCaption?exists && form.showCaption>
         <div id="${formId}-caption" class="caption"><span class="mandatory-indicator">*</span>${msg("form.required.fields")}</div>
      </#if>
         
      <#if form.mode != "view">
         <form id="${formId}" method="${form.method}" accept-charset="utf-8" enctype="${form.enctype}" action="${form.submissionUrl}">
      </#if>
      
      <div id="${formId}-fields" class="form-fields"> 
        <div id="${formId}-tabview" class="yui-navset"> 
			<ul class="yui-nav">
				<#list form.items as item>
					<#if item.kind == "set">
						<li <#if item_index == 0>class="selected"</#if>><a href="#tab_${item_index}"><em>${item.label}</em></a></li>
					</#if>
				</#list>
				<li><a href="#tab_others"><em>Others</em></a></li>
			</ul>     				
			<div class="yui-content">
				<#list form.items as item>
					<#if item.kind == "set">
					   <div id="tab_${item_index}">
					   		<@renderSetWithoutColumns set=item />
					   </div>		
					</#if>
				 </#list>
				 <div id="tab_others">
					<#list form.items as item>
						<#if item.kind != "set">
						   	<@formLib.renderField field=item />
						</#if>
					 </#list>
				 </div>	 
			</div> 
         </div>
      </div>
         
      <#if form.mode != "view">
         <@formLib.renderFormButtons formId=formId />
         </form>
      </#if>

   </div>
</#if>

<#macro renderSetWithColumns set>
   <#if set.appearance?exists>
      <#if set.appearance == "fieldset">
         <fieldset><legend>${set.label}</legend>
      <#elseif set.appearance == "panel">
         <div class="form-panel">            
            <div class="form-panel-body">
      </#if>
   </#if>
   
   <#list set.children as item>
      <#if item.kind == "set">
         <@renderSetWithColumns set=item />
      <#else>
         <#if (item_index % 2) == 0>
         <div class="yui-g"><div class="yui-u first">
         <#else>
         <div class="yui-u">
         </#if>
         <@formLib.renderField field=item />
         </div>
         <#if ((item_index % 2) != 0) || !item_has_next></div></#if>
      </#if>
   </#list>
   
   <#if set.appearance?exists>
      <#if set.appearance == "fieldset">
         </fieldset>
      <#elseif set.appearance == "panel">
            </div>
         </div>
      </#if>
   </#if>
</#macro>

<#macro renderSet set>
   <#if set.appearance?exists>
      <#if set.appearance == "fieldset">
         <fieldset><legend>${set.label}</legend>
      <#elseif set.appearance == "panel">
         <div class="form-panel">
            <div class="form-panel-heading">${set.label}</div>
            <div class="form-panel-body">
      <#elseif set.appearance == "accordion">
      <div class="yui-skin-sam">
      	<div class="yui-cms-accordion multiple fade fixIE">	  
	  	    <div class="yui-cms-item yui-panel">
	              <div class="hd">${set.label}</div>
	              <div class="bd">
	                <div class="fixed">
      </#if>
   </#if>
   
   <#list set.children as item>
      <#if item.kind == "set">
         <@renderSet set=item />
      <#else>
         <@formLib.renderField field=item />
      </#if>
   </#list>
   
   <#if set.appearance?exists>
      <#if set.appearance == "fieldset">
         </fieldset>
      <#elseif set.appearance == "panel">
            </div>
         </div>
      <#elseif set.appearance == "accordion">
					</div>
            	</div>
            <div class="actions">
		      <a href="#" class="accordionToggleItem">&nbsp;</a>
		    </div>
		 </div>
       </div>
       </div>
      </#if>
   </#if>
</#macro>

<#macro renderSetWithoutColumns set>
   <#if set.appearance?exists>
      <#if set.appearance == "fieldset">
         <fieldset><legend>${set.label}</legend>
      <#elseif set.appearance == "panel">
         <div class="form-panel">
            <div class="form-panel-body">
      </#if>
   </#if>
   
   <#list set.children as item>
      <#if item.kind == "set">
         <@renderSet set=item />
      <#else>
         <@formLib.renderField field=item />
      </#if>
   </#list>
   
   <#if set.appearance?exists>
      <#if set.appearance == "fieldset">
         </fieldset>
      <#elseif set.appearance == "panel">
            </div>
         </div>
      </#if>
   </#if>
</#macro>


<script>
(function() {
    var tabView = new YAHOO.widget.TabView('${formId}-tabview');
})();
</script>
