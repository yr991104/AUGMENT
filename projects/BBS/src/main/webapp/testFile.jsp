<input type="file" name="zipFile" id="zipFile" onchange="file_Url_Upload('FILE');"/>
....
function file_Url_Upload(){
$('#templateForm').attr('action','<c:url value="/ZipFileUpload.do"/>').ajaxSubmit({
dataType : 'json'
, success : function(result) {
setContent(result.file_contents);
}
, error : function(result) {
}
}).attr('action','<c:url value="/MyTemplateRegister.do"/>');
}