<#if field.control.params.ds?exists><#assign ds=field.control.params.ds><#else><#assign ds=''></#if>
<#if field.control.params.width?exists><#assign width=field.control.params.width><#else><#assign width='35em'></#if>

<style type="text/css">
#${fieldHtmlId}-AutoComplete {
    width:${width}; /* set width here or else widget will expand to fit its container */
    padding-bottom:2em;
}
</style>

<div class="form-field">
   <#if form.mode == "view">
      <div class="viewmode-field">
         <#if field.mandatory && !(field.value?is_number) && field.value == "">
            <span class="incomplete-warning"><img src="${url.context}/components/form/images/warning-16.png" title="${msg("form.field.incomplete")}" /><span>
         </#if>
         <span class="viewmode-label">${field.label?html}:</span>
         <span class="viewmode-value">${field.value?html}</span>
      </div>
   <#else>
      <label for="${fieldHtmlId}">${field.label?html}:<#if field.mandatory><span class="mandatory-indicator">${msg("form.required.fields.marker")}</span></#if></label>
	  <div id="${fieldHtmlId}-AutoComplete">
	      <input id="${fieldHtmlId}" type="text" name="${field.name}" 
			 <#if field.control.params.styleClass?exists>class="${field.control.params.styleClass}"</#if>
			 <#if field.value?is_number>value="${field.value?c}"<#else>value="${field.value}"</#if>
			 <#if field.description?exists>title="${field.description}"</#if>
			 <#if field.control.params.maxLength?exists>maxlength="${field.control.params.maxLength}"</#if> 
			 <#if field.control.params.size?exists>size="${field.control.params.size}"</#if> 
			 <#if field.disabled>disabled="true"</#if> />
	      <div id="${fieldHtmlId}-Container"></div>       
	  </div>
   </#if>
</div>

<script type="text/javascript">//<![CDATA[
(function()
{
		// Use an XHRDataSource
		var oDS = new YAHOO.util.XHRDataSource("${ds}");
		// Set the responseType
		oDS.responseType = YAHOO.util.XHRDataSource.TYPE_JSON;
		// Define the schema of the JSON results
		oDS.responseSchema = {
			resultsList : "result",
			fields : ["value"]
		};

		// Instantiate the AutoComplete
		var oAC = new YAHOO.widget.AutoComplete("${fieldHtmlId}", "${fieldHtmlId}-Container", oDS);
		// Throttle requests sent
		oAC.queryDelay = .5;
		// The webservice needs additional parameters
		oAC.generateRequest = function(sQuery) {
			<#if ds?contains("?")>
				return "&q=" + sQuery ;
			<#else>
				return "?q=" + sQuery ;
			</#if>
		};

		return {
			oDS: oDS,
			oAC: oAC
		};
})();
//]]></script>


