var str = "<option value='' code-discount=''>请选择</option>";
<activity-list>
  str += "<option value='${fld:code}' code-discount='${fld:discount}'>${fld:campaign_name@js}</option>";
</activity-list>
$("#campaigncode").html(str);
$('#campaigncode').val($('#incampaigncode').val());
