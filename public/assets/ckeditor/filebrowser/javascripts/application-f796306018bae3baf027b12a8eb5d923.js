$.QueryString=function(e){if(""==e)return{};for(var t={},i=0;i<e.length;++i){var l=e[i].split("=");2==l.length&&(t[l[0]]=decodeURIComponent(l[1].replace(/\+/g," ")))}return t}(window.location.search.substr(1).split("&")),$(document).ready(function(){$("div.gal-item div.gal-inner-holder").live("mouseover",function(){$(this).addClass("hover")}).live("mouseout",function(){$(this).removeClass("hover")}).live("click",function(){var e=$(this).parents("div.gal-item").data("url");CKEDITOR.tools.callFunction(CKEditorFuncNum,e),window.close()}),$("div.gal-item a.gal-del").live("ajax:complete",function(){$(this).parents("div.gal-item").remove()});var e=$.endlessScroll({container:".fileupload-list",entity:".gal-item",scrollPadding:100});e.scrollModule.unbind(),window.setTimeout(function(){e.scrollModule.bind()},1e3)}),qq.FileUploader.instances=new Object,qq.FileUploaderInput=function(e){qq.FileUploaderBasic.apply(this,arguments),qq.extend(this._options,{element:null,listElement:null,template_id:"#fileupload_tmpl",classes:{button:"fileupload-button",drop:"fileupload-drop-area",dropActive:"fileupload-drop-area-active",list:"fileupload-list",preview:"fileupload-preview",file:"fileupload-file",spinner:"fileupload-spinner",size:"fileupload-size",cancel:"fileupload-cancel",success:"fileupload-success",fail:"fileupload-fail"}}),qq.extend(this._options,e),this._element=document.getElementById(this._options.element),this._listElement=this._options.listElement||this._find(this._element,"list"),this._classes=this._options.classes,this._button=this._createUploadButton(this._find(this._element,"button")),qq.FileUploader.instances[this._element.id]=this},qq.extend(qq.FileUploaderInput.prototype,qq.FileUploaderBasic.prototype),qq.extend(qq.FileUploaderInput.prototype,{_find:function(e,t){var i=qq.getByClass(e,this._options.classes[t])[0];if(!i)throw alert(t),new Error("element not found "+t);return i},_setupDragDrop:function(){var e=this,t=this._find(this._element,"drop"),i=new qq.UploadDropZone({element:t,onEnter:function(i){qq.addClass(t,e._classes.dropActive),i.stopPropagation()},onLeave:function(e){e.stopPropagation()},onLeaveNotDescendants:function(){qq.removeClass(t,e._classes.dropActive)},onDrop:function(i){t.style.display="none",qq.removeClass(t,e._classes.dropActive),e._uploadFileList(i.dataTransfer.files)}});t.style.display="none",qq.attach(document,"dragenter",function(e){i._isValidFileDrag(e)&&(t.style.display="block")}),qq.attach(document,"dragleave",function(e){if(i._isValidFileDrag(e)){var l=document.elementFromPoint(e.clientX,e.clientY);l&&"HTML"!=l.nodeName||(t.style.display="none")}})},_onSubmit:function(e,t){qq.FileUploaderBasic.prototype._onSubmit.apply(this,arguments),this._addToList(e,t)},_onProgress:function(e,t,i,l){qq.FileUploaderBasic.prototype._onProgress.apply(this,arguments);var s,n=this._getItemByFileId(e),o=this._find(n,"size");s=i!=l?Math.round(i/l*100)+"% from "+this._formatSize(l):this._formatSize(l),qq.setText(o,s)},_onComplete:function(e,t,i){qq.FileUploaderBasic.prototype._onComplete.apply(this,arguments);var l=this._getItemByFileId(e),s=i.asset?i.asset:i;s&&s.id?(qq.addClass(l,this._classes.success),s.size=this._formatSize(s.size),s.controller="ckeditor::picture"==s.type.toLowerCase()?"pictures":"attachment_files",$(l).replaceWith($(this._options.template_id).tmpl(s))):qq.addClass(l,this._classes.fail)},_addToList:function(e,t){if(this._listElement){this._options.multiple===!1&&$(this._listElement).empty();var i={id:0,filename:this._formatFileName(t),size:0,format_created_at:"",url_content:"#",controller:"assets",url_thumb:"/assets/ckeditor/filebrowser/images/preloader-f3566e7d1e3b814e9c1d89f975b2463a.gif"},l=$(this._options.template_id).tmpl(i).attr("qqfileid",e).prependTo(this._listElement);l.find("div.img").addClass("preloader"),this._bindCancelEvent(l)}},_getItemByFileId:function(e){return $(this._listElement).find("div[qqfileid="+e+"]").get(0)},_bindCancelEvent:function(e){var t=this,i=$(e);i.find("a."+this._classes.cancel).bind("click",function(e){return t._handler.cancel(i.attr("qqfileid")),i.remove(),qq.preventDefault(e),!1})}});