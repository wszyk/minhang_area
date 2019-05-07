


var LayuiHelp = {
    /*
    *   index==0;感叹号
    *   index==1;正确，打钩
    *   index==2;错误，打叉
    *   index==3;问号
    *   index==4;加锁
    *   index==5;生气表情
    *   index==6;开心表情
    */
    MessageLayui: function () {
        return {
            title: "提示",
            index: 0,
            msg: "您还没有输入内容！",
            sure: "", //确认按钮的回调事件
            cancel: "", //取消按钮的回调事件
            show: function () {
                var MsgJson = [];
                var sureCallback = this.sure;
                var CancelCallBack = this.cancel;

                if (this.cancel == "") {
                    MsgJson = {
                        title: this.title,
                        offset: '15%',
                        icon: this.index,
                        btn: ['确认'],
                        yes: function (index) {
                            if (sureCallback != undefined && sureCallback != "") {
                                sureCallback();
                            }
                            layer.close(index);
                        }
                    }
                }
                else if (sureCallback == undefined && sureCallback != "" && CancelCallBack != undefined && CancelCallBack != "") {
                    MsgJson = {
                        title: this.title,
                        offset: '15%',
                        icon: this.index,
                        btn: ['取消'],
                        yes: function (index) {
                            if (CancelCallBack != undefined && CancelCallBack != "") {
                                CancelCallBack();
                            }
                            layer.close(index);
                        }
                    }
                }
                else {
                    MsgJson = {
                        title: this.title,
                        offset: '15%',
                        icon: this.index,
                        btn: ['确认', '取消'],
                        yes: function (index) {
                            if (sureCallback != undefined && sureCallback != "") {
                                sureCallback();
                            }
                            layer.close(index);
                        }, btn2: function (index, layero) {
                            if (CancelCallBack != undefined && CancelCallBack != "") {
                                CancelCallBack();
                            }
                            layer.close(index);
                        }
                    }
                }
                var Msg = this.msg;
                //调用弹窗方法
                layui.use('layer', function () {
                    layui.layer.confirm(Msg, MsgJson);
                });
            }
        }
    },
    /*
    创建表格
    如果页面需要创建多个表格，则使用该语句：var Table_Layui1=Table_Layui,然后使用对象Table_Layui1去操作
    */
    TableLayui: function () {
        return {
            //Table的模块ID--建议使用Div
            TablePanel: "",
            //皮肤,使用的是Layui表格中的lay-skin
            TableSkin: "",
            //是否需要序号
            CountNumberBool: true,
            //随鼠标移动的切换的行颜色
            //假如需要使用多种颜色进行轮换切换，多加入几个json字串即可，比如：[{ color: "#f8f8f8"},{ color: "#1e9fff"}]
            RowChangeColour: [{ color: "#F8F8F8"}],
            //table 初始化
            Column: [{
                txtName: "", //必填，列标题的名称
                valueCode: "", //必填，列值的取值编码
                width: 80, //选填，列的长度,默认为80px
                style: "", //选填，"自定义列的样式",将作用到每一列
                visible: true, //选填，该列是否显示出来，默认为显示
                //选填，编辑选项设置，如果不传入该选项值，则默认该列不处理编辑
                Edit: {
                    Show: true, //是否显示到编辑框中，默认为显示
                    Width: 120, //编辑框的长度，默认为120px
                    Type: "txt", //显示的编辑框中控件样式，默认为文本框,样式对应  txt:文本框,select:下拉框,radio:单选框,checkbox:多选框
                    //假如是下拉框，需要在这里赋上下拉框的初始化值
                    Data: [{
                        Name: "显示的名称",
                        Value: "对应的值"
                    }],
                    //自定义数据集的取值配置
                    DateKey: { ValueKey: "值得关键字", NameKay: "名称的关键字" }
                },
                //选填，自定义的处理值得方法
                valueDeal: function (value) {
                    return value;
                }
            }],
            //编辑方法
            Edit: "",
            //编辑模板的配置
            EditModeSetting: {
                flag: 1, //模式标志0：编辑，1：新增
                SplitFlag: ",", //编辑控件返回的多值间隔符，比如，复选框选中的值，必然是多个的，那么多个值将会使用这里定义的间隔符间隔开
                DataIndex: 1, //编辑的数据行数
                //编辑框的尺寸配置
                Size: {
                    Width: 300, //编辑框的宽度
                    Height: 400, //编辑框的高度
                    NameWidth: 120//编辑框中编辑对象的名称的宽度
                },
                SureCallBack: undefined //确认回调事件
            },
            //删除方法
            Delete: "",
            data: [],
            //当前页
            PageIndex: 1,
            //每页展示的数据量
            PageSize: 10,
            //总数据量，假如该值为0，则表示不需要创建页码
            SumDateCounte: 0,
            //根据页码查询指定数据的方法
            SelectDataByPageIndex: function (index) { },
            //获取指定行数据
            GetRowData: function (index) {
                return this.data[index];
            },
            //页码
            Page_Layui: LayuiHelp.PageLayui(),
            //创建Layui的表格框架
            CreateTableFrame: function () {
                //表格的ID
                var tableID = "LayuiTable" + LayuiHelp.Common.GetNowTimeTimer();


                var Message = LayuiHelp.MessageLayui();
                var width = 0;
                var colgroupHtml = ""; //头部宽度样式
                var theadHtml = ""; //列标题的html
                var ifcontinue = true; //是否继续执行下去，用于程序过程中判断
                //序号字段
                if (this.CountNumberBool) {
                    width = 80;
                    colgroupHtml = "<col style='80'>";
                    theadHtml = "<th>序号</th>";
                }
                //列标题
                var Column = this.Column;

                var ColumnEditFlag = false;
                for (var i = 0; i < Column.length; i++) {
                    if (Column[i].txtName == undefined) {
                        Column[i].txtName = "";
                    }
                    if (Column[i].valueCode == undefined || Column[i].valueCode == "") {
                        Message.msg = "第" + (i + 1) + "列的取值编码不能为空！";
                        Message.show();
                        ifcontinue = false;
                        break;
                    }
                    if (Column[i].visible != undefined) {
                        if (Column[i].visible == false) {
                            continue; //跳出当前循环，当前列不被显示
                        }
                    }
                    if (Column[i].Edit != undefined) {
                        ColumnEditFlag = true; //表示存在列需要编辑
                    }
                    //编辑判断
                    if (ColumnEditFlag) {
                        if (this.Edit == "") {
                            Message.msg = "您启用了编辑列，却没有设置编辑保存事件";
                            Message.show();
                            ifcontinue = false;
                            break;
                        }
                    }
                    //书写当前列标题
                    var ColumnWidth = Column[i].width == undefined ? 80 : Column[i].width;
                    width += ColumnWidth;
                    colgroupHtml += "<col  width='" + ColumnWidth + "'>";
                    theadHtml += "<th style='" + (Column[i].Style == undefined ? "" : Column[i].Style) + "'>" + Column[i].txtName + "</th>";
                }

                //控制按钮 的列标题
                if (this.Edit != "" || this.Delete != "") {
                    width += 120;
                    colgroupHtml += "<col  width='120'>";
                    theadHtml += "<th></th>";
                }
                //数据
                var tbody = "";
                if (this.data != undefined && this.data != null && ifcontinue) {
                    if (this.data.length > 0) {
                        for (var i = 0; i < this.data.length; i++) {
                            tbody += "<tr id='" + tableID + "tr_" + i + "'>";
                            //序号
                            if (this.CountNumberBool) {
                                tbody += "<td style='text-align: center;'>" + ((parseFloat(this.PageIndex) - 1) * this.PageSize + i + 1) + "</td>";
                            }
                            for (var j = 0; j < Column.length; j++) {
                                if (Column[j].visible != undefined) {
                                    if (Column[j].visible == false) {
                                        continue; //跳出当前循环，当前列不被显示
                                    }
                                }
                                //单元格的样式
                                tbody += "<td style=\"cursor: pointer;word-break : normal | break-all | keep-all;" + (Column[j].Style == undefined ? "" : Column[j].Style) + "\">";
                                var value = "";
                                //单元格的数据
                                if (Column[j].valueDeal != undefined) {
                                    value = Column[j].valueDeal(this.data[i][Column[j].valueCode]);
                                }
                                else {
                                    value = this.data[i][Column[j].valueCode];
                                }
                                tbody += (value == null ? "" : value) + "</td>";
                            }
                            //控制按钮
                            if (this.Edit != "" || this.Delete != "") {
                                tbody += "<td>";
                                //编辑按钮功能
                                if (this.Edit != "") {
                                    tbody += "<button class='layui-btn layui-btn-normal layui-btn-mini' onclick='" + this.Edit + "(" + i + ")' > <i class='layui-icon'>&#xe642;</i></button>";
                                }
                                //删除按钮功能
                                if (this.Delete != "") {
                                    tbody += "<button class='layui-btn layui-btn-normal layui-btn-mini' onclick='" + this.Delete + "(" + i + ")' > <i class='layui-icon'>&#xe640;</i></button>";
                                }
                                tbody += "</td>";
                            }
                            tbody += "</tr>";
                        }
                    }
                }
                //初始化分页容器的ID
                if (this.Page_Layui.PagePlaneID == "") {
                    this.Page_Layui.PagePlaneID = new Date().getTime();
                }

                var html = "<div style='width:" + (width < 430 ? 430 : width) + "px;'>"
                     + " <table id='" + tableID + "' class='layui-table' lay-skin='" + (this.TableSkin == "" ? "" : this.TableSkin) + "'>"
                     + "    <colgroup>"
                     + colgroupHtml
                     + "    </colgroup>"
                     + "    <thead> "
                     + "        <tr>"
                     + theadHtml
                     + "        </tr>"
                     + "    </thead>"
                     + "    <tbody >" + tbody + "</tbody>"
                     + " </table>"
                     + " <div id=\"" + this.Page_Layui.PagePlaneID + "\"></div>";
                html += "</div>";
                if (ifcontinue) {
                    $("#" + this.TablePanel).html(html);
                    //创建页码
                    if (this.SumDateCounte > 0) {
                        this.Page_Layui.PageIndex = this.PageIndex;
                        this.Page_Layui.PageSize = this.PageSize;
                        this.Page_Layui.SumDateCounte = this.SumDateCounte;
                        this.Page_Layui.SelectDataByPageIndex = this.SelectDataByPageIndex;
                        this.Page_Layui.CreatePage(); //创建页码
                    }
                }


                if (this.RowChangeColour != undefined) {
                    var RowChangeColour = this.RowChangeColour;
                    //鼠标离开--默认颜色--
                    $("#" + tableID + " tbody tr").mouseleave(function () {
                        $(this).css("background-color", "#ffffff");
                    });
                    //鼠标移动到事件
                    $("#" + tableID + " tbody tr").mousemove(function () {
                        var Count = parseInt($(this).attr("id").split('_')[1])+1;
                        var length = RowChangeColour.length;
                        var num = Count - parseInt(Count / length) * length;
                        $(this).css("background-color", RowChangeColour[num].color);
                    });
                }
            },
            //创建编辑模板窗口,flag:
            //DataIndex：
            //SureCallBack，
            //需注意(具体可参照Demo)，
            //编辑保存的返回值是data中编辑的那一行数据，
            //新增的保存的返回值是Column中定义的那些可编辑的ValueCode
            CreateEditMode: function () {
                //编辑框的初始化配置
                var flag = 1; //编辑模式：0 编辑，1新增    
                var DataIndex = 1; //编辑时所需的数据的行数
                //保存方法的回调事件,默认为空事件
                var SureCallBack = function () { };
                //编辑框的尺寸配置
                var Size = {
                    Width: 400, //编辑框的宽度
                    Height: 0, //编辑框的高度，默认为0，采用系统自动适配
                    NameWidth: 120//编辑框中编辑对象的名称的宽度
                }

                if (this.EditModeSetting.flag != undefined
                    || this.EditModeSetting.flag != null
                    || this.EditModeSetting.flag != "") {
                    flag = this.EditModeSetting.flag;
                }
                if (this.EditModeSetting.DataIndex != undefined
                    || this.EditModeSetting.DataIndex != null
                    || this.EditModeSetting.DataIndex != "") {
                    DataIndex = this.EditModeSetting.DataIndex;
                }
                if (this.EditModeSetting.SureCallBack != undefined) {
                    SureCallBack = this.EditModeSetting.SureCallBack;
                }
                if (this.EditModeSetting.Size != undefined) {
                    if (this.EditModeSetting.Size.Width != undefined) {
                        Size.Width = this.EditModeSetting.Size.Width;
                    }
                    if (this.EditModeSetting.Size.Height != undefined) {
                        Size.Height = this.EditModeSetting.Size.Height;
                    }
                    if (this.EditModeSetting.Size.NameWidth != undefined) {
                        Size.NameWidth = this.EditModeSetting.Size.NameWidth;
                    }
                }
                var EditModeID = new Date().getTime();
                var TableColumn = this.Column;
                var json = [];
                if (flag == 0) {
                    json = this.GetRowData(DataIndex); //获取待编辑行的数据
                }
                var MaxValueWidth = 0; //自定义配置的最大编辑控件宽度
                var ifcontinue = true;
                var EditModeHtml = "<div id='EditMode'  style='margin-bottom: 15px;' >"
                for (var i = 0; i < TableColumn.length; i++) {
                    if (TableColumn[i].Edit != undefined) {
                        var Show = true;
                        if (TableColumn[i].Edit.Show != undefined) {
                            if (TableColumn[i].Edit.Show != false) {
                                Show = false;
                            }
                        }
                        if (Show) {
                            var style = "width:120px;"
                            if (TableColumn[i].Edit.Width != undefined) {
                                MaxValueWidth = TableColumn[i].Edit.Width > MaxValueWidth ? TableColumn[i].Edit.Width : MaxValueWidth;
                                style = "width:" + TableColumn[i].Edit.Width + "px;"
                            }
                            var Type = "txt";
                            if (TableColumn[i].Edit.Type != undefined) {
                                if (
                                TableColumn[i].Edit.Type != "txt"
                                && TableColumn[i].Edit.Type != "select"
                                && TableColumn[i].Edit.Type != "radio"
                                && TableColumn[i].Edit.Type != "checkbox") {
                                    Message.msg = "第" + (i + 1) + "列未能识别的编辑控件：" + TableColumn[i].Edit.Type;
                                    Message.show();
                                    ifcontinue = false;
                                    break;
                                } else {
                                    Type = TableColumn[i].Edit.Type;
                                }
                            }
                            EditModeHtml += "<div class='layui-item' style='margin-top:15px; '>";
                            EditModeHtml += "<label class='layui-form-label' style='width:" + Size.NameWidth + "px;padding: 9px 0px;'>" + TableColumn[i].txtName + "：</label>";

                            //文本框
                            if (Type == "txt") {
                                EditModeHtml += "<input id='" + EditModeID + TableColumn[i].valueCode + "' type='text' class='layui-input'placeholder='输入" + TableColumn[i].txtName + "' style='" + style + "' " + (flag == 0 ? "value='" + json[TableColumn[i].valueCode] + "'" : "") + " />";
                            }
                            //下拉框,单选按钮，多选按钮
                            else if (Type == "select" || Type == "radio" || Type == "checkbox") {
                                if (TableColumn[i].Edit.Data == undefined) {
                                    Message.msg = "第" + (i + 1) + "列的编辑控件数据集错误：";
                                    Message.show();
                                    ifcontinue = false;
                                    break;
                                } else {
                                    if (Type == "select") {
                                        EditModeHtml += "<select id='" + EditModeID + TableColumn[i].valueCode + "' class='layui-input' style='" + style + "'>";
                                    } else if (Type == "radio" || Type == "checkbox") {
                                        EditModeHtml += "<div class='layui-input-block layui-form' style='margin-left: " + (Size.NameWidth + 5) + "px;" + style + "'>";
                                    }

                                    if (TableColumn[i].Edit.Data == undefined) {
                                        Message.msg = "第" + (i + 1) + "列的编辑控件数据集没有赋值！";
                                        Message.show();
                                        ifcontinue = false;
                                        break;
                                    }
                                    for (var j = 0; j < TableColumn[i].Edit.Data.length; j++) {
                                        var ValueKey = "Value";
                                        var NameKey = "Name";
                                        if (TableColumn[i].Edit.Data[j] == undefined) {
                                            continue;
                                        }
                                        if (TableColumn[i].Edit.DateKey != undefined) {
                                            ValueKey = TableColumn[i].Edit.DateKey.ValueKey;
                                            NameKey = TableColumn[i].Edit.DateKey.NameKey;
                                            if (ValueKey == undefined || ValueKey == undefined) {
                                                Message.msg = "第" + (i + 1) + "列的编辑控件下拉框的选项数据集自定义取值字段的设置不正确！";
                                                Message.show();
                                                ifcontinue = false;
                                                break;
                                            }
                                        }
                                        if (Type == "select") {
                                            //取值
                                            EditModeHtml += " <option value='" + TableColumn[i].Edit.Data[j][ValueKey] + "'  "
                                            //设置默认选中项
                                            EditModeHtml += (flag == 0 ? (json[TableColumn[i].valueCode] == TableColumn[i].Edit.Data[j][ValueKey] ? "selected = 'selected'" : "") : "") + "  >"
                                            //显示名称
                                            EditModeHtml += TableColumn[i].Edit.Data[j][NameKey] + "</option>";
                                        } else if (Type == "radio" || Type == "checkbox") {
                                            EditModeHtml += "<input type='" + Type + "' name='" + EditModeID + TableColumn[i].valueCode + "' value='" + TableColumn[i].Edit.Data[j][ValueKey] + "' title='" + TableColumn[i].Edit.Data[j][NameKey] + "' ";
                                            EditModeHtml += (flag == 0 ? (json[TableColumn[i].valueCode] == TableColumn[i].Edit.Data[j][ValueKey] ? " checked " : "") : "") + "  >";
                                        }
                                    }
                                    if (Type == "select") {
                                        EditModeHtml += "</select>";
                                    } else if (Type == "radio" || Type == "checkbox") {
                                        EditModeHtml += "</div>";
                                    }
                                }
                            } //下拉框,单选按钮，多选按钮--结束
                            EditModeHtml += "</div>";
                        }
                    }
                }
                EditModeHtml += "</div>";
                //编辑模板拼接完成
                if (ifcontinue) {
                    var Tips = flag == 0 ? "编辑" : "新增";
                    var area = this.EditModeSetting.Size.Width + 'px';
                    if (this.EditModeSetting.Size.Height > 0) {
                        area = [this.EditModeSetting.Size.Width + 'px', this.EditModeSetting.Size.Height + 'px']
                    }
                    var SplitFlag = ",";
                    if (this.EditModeSetting.SplitFlag != undefined) {
                        SplitFlag = this.EditModeSetting.SplitFlag;
                    }
                    layer.open({
                        offset: ['12%', '30%'],
                        area: area,
                        title: Tips,
                        type: 1,
                        content: EditModeHtml,
                        btnAlign: 'c',
                        btn: ['确认', '取消'],
                        yes: function (index, layero) {
                            //EditModeID
                            var rtnJson = {};
                            for (var i = 0; i < TableColumn.length; i++) {
                                var thisvalue = "";
                                var Type = "txt";
                                if (TableColumn[i].Edit != undefined) {
                                    if (TableColumn[i].Edit.Type != undefined) {
                                        Type = TableColumn[i].Edit.Type;
                                    }
                                }
                                if (Type == "txt" || Type == "select") {
                                    thisvalue = $("#" + EditModeID + TableColumn[i].valueCode).val();
                                } else if (Type == "radio" || Type == "checkbox") {
                                    var CheckedObj = $("input[name='" + EditModeID + TableColumn[i].valueCode + "']");
                                    for (var Ci = 0; Ci < CheckedObj.length; Ci++) {
                                        if (CheckedObj[Ci].checked) {
                                            if (thisvalue != "")
                                                thisvalue += SplitFlag;
                                            thisvalue += $(CheckedObj[Ci]).val();
                                        }
                                    }
                                }
                                if (thisvalue != undefined) {
                                    //编辑事件
                                    if (flag == 0) {
                                        json[TableColumn[i].valueCode] = thisvalue;
                                    }
                                    rtnJson[TableColumn[i].valueCode] = thisvalue;
                                }
                            }
                            if (SureCallBack != undefined) {
                                if (flag == 0) {
                                    SureCallBack(json);
                                } else {
                                    SureCallBack(rtnJson);
                                }
                            }
                            layer.close(index);
                        }, btn2: function (index, layero) {
                            //取消
                        },
                        end: function () {
                        }
                    });

                    layui.use('form', function () {
                        var form = layui.form();
                        form.render();
                    });


                }

            }
        };
    },
    /*
    创建页码
    如果页面需要创建多个页码，则使用该语句：var Page_Layui1=Page_Layui,然后使用对象Page_Layui1去操作
    */
    PageLayui: function () {
        return {
            //存放页码的容器
            PagePlaneID: "",
            //当前页
            PageIndex: 1,
            //每页展示的数据量
            PageSize: 10,
            //数据的总数量
            SumDateCounte: 0,
            //根据页码查询数据的方法
            SelectDataByPageIndex: function (PageIndex) { },
            //刷新当前页数据
            Refresh: function () { this.SelectDataByPageIndex(this.PageIndex); },
            CreatePage: function () {
                $("#" + this.PagePlaneID).css("width", "100%");
                $("#" + this.PagePlaneID).css("text-align", "right");
                var Page_Layui_PageSelect = this.SelectDataByPageIndex;
                var Page_Layui_PageID = this.PagePlaneID;
                var Page_Layui_PageIndex = this.PageIndex;
                var SumPage = Math.ceil(this.SumDateCounte / this.PageSize);
                layui.use(['laypage', 'layer'], function () {
                    var laypage = layui.laypage
                        , layer = layui.layer;
                    laypage({
                        cont: Page_Layui_PageID
                            , curr: Page_Layui_PageIndex
                          , pages: SumPage //总页数
                          , groups: 5 //连续显示分页数
                          , jump: function (obj, first) {
                              //得到了当前页，用于向服务端请求对应数据
                              if (!first) {
                                  //$("#" + thisPageIndexLabelID).val(obj.curr);
                                  Page_Layui_PageSelect(obj.curr);
                              }
                          }
                    });
                });
            }
        }
    },
    /*
    可编辑控件
    */
    EditControl: function () {
        return {
            /*基础配置： 
            id:必填，容器的ID（容器推荐使用p元素），
            value：初始值，默认为空
            ShowType:显示的值控件的类型，默认为span，类型注释：span
            EditType:编辑控件的类型，默认为文本框，类型注释：txt（文本框）
            width:编辑控件的宽度，默认为120px;
            height:编辑控件的高度，默认为30px;
            */
            Base: [
                    { id: 'NameSpan', value: '老张', ShowType: 'span', EditType: 'txt', width: '120', height: '30' }
                  ],

            //控件加载
            Lode: function () {
                var Message = LayuiHelp.MessageLayui();
                var timerFlag = "EC_" + LayuiHelp.Common.GetNowTimeTimer();

                for (var i = 0; i < this.Base.length; i++) {
                    var Flag = timerFlag + i;

                    if (this.Base[i].id == undefined) {
                        Message.msg = "可编辑控件的容器ID不能为空！";
                        Message.show();
                        break;
                    }
                    var id = this.Base[i].id;
                    var value = this.Base[i].value != undefined ? this.Base[i].value : "";
                    var ShowType = this.Base[i].ShowType != undefined ? this.Base[i].ShowType : "span";
                    var EditType = this.Base[i].EditType != undefined ? this.Base[i].EditType : "txt";
                    var width = this.Base[i].width != undefined ? this.Base[i].width : "120";
                    var height = this.Base[i].height != undefined ? this.Base[i].height : "30";
                    //容器样式初始化
                    $("#" + id).css("display", "inline-block");
                    $("#" + id).css("width", width);
                    $("#" + id).css("height", height);
                    //值初始化
                    $("#" + id).val(value);
                    //内部元素拼接
                    var html = "";
                    //值控件
                    if (ShowType == "span") {
                        html += "<span id='" + Flag + "_Value' style='cursor:pointer;display:inline-block;width:" + width + "px;height:" + height + "px;line-height:" + height + "px;'>" + value + "</span>";
                    }
                    //编辑控件             
                    if (EditType = "txt") {
                        html += "<input id='" + Flag + "_Edit' type='text' class='layui-input' style='display:none;width:" + width + "px;height:" + height + "px;' />";
                    }

                    $("#" + id).html(html);
                    //值模块的单击事件绑定
                    this.ValueClickBind(id, Flag, ShowType, EditType);
                    //编辑模块的完成事件后绑定：光标移开后等
                    this.EditFinshBind(id, Flag, ShowType, EditType);
                }
            }, //Lode方法结束
            //值模块的单击绑定事件
            ValueClickBind: function (id, Flag, ShowType, EditType) {
                $("#" + Flag + "_Value").click(function () {
                    //如果值数据不是隐藏状态，触发
                    if (!$("#" + Flag + "_Value").is(":hidden")) {
                        $("#" + Flag + "_Value").hide();
                        $("#" + Flag + "_Edit").css("display", "inline");
                        var value = "";
                        //span
                        if (ShowType == "span") {
                            value = $("#" + Flag + "_Value").html();
                        }
                        if (EditType == "txt") {
                            $("#" + Flag + "_Edit").val(value);
                            $("#" + Flag + "_Edit").focus();
                        }
                    }
                });
            },
            //编辑模块完成后的绑定事件
            EditFinshBind: function (id, Flag, ShowType, EditType) {
                $("#" + Flag + "_Edit").blur(function () {
                    //如果值数据是隐藏状态，触发
                    if ($("#" + Flag + "_Value").is(":hidden")) {
                        $("#" + Flag + "_Value").css("display", "inline-block");
                        $("#" + Flag + "_Edit").hide();
                        var value = "";
                        //文本框
                        if (EditType == "txt") {
                            value = $("#" + Flag + "_Edit").val();
                        }
                        //span
                        if (ShowType == "span") {
                            $("#" + Flag + "_Value").html(value);
                            $("#" + id).val(value);
                        }
                    }
                });
            },
            //获取指定id控件的值
            GetValue: function (id) {
                return $("#" + id).val();
            },
            //获取所有控件的值
            GetValues: function () {
                var Message = LayuiHelp.MessageLayui();
                var josn = "(";
                for (var i = 0; i < this.Base.length; i++) {
                    var Flag = timerFlag + i;
                    if (this.Base[i].id == undefined) {
                        Message.msg = "可编辑控件的容器ID不能为空！";
                        Message.show();
                        break;
                    }
                    json += "'" + this.Base[i].id + "':'" + $("#" + this.Base[i].id).val() + "'";
                }
                json += ")";
                return eval(json);
            }
        };
    },
    /*
    一般工具类
    */
    Common: {
        //获取当前时间
        GetNowTime: function () {
            return new Date();
        },
        //获取当前时间毫秒数
        GetNowTimeTimer: function () {
            return new Date().valueOf();
        },
        //获取url中的指定参数的值，如果参数不存在，返回空字串
        //paramName:参数名称
        getParam: function (paramName) {
            paramValue = "";
            isFound = false;
            paramName = paramName.toLowerCase();
            if (location.search.indexOf("?") == 0 && location.search.indexOf("=") > 1) {
                arrSource = unescape(location.search).substring(1, location.search.length).split("&");
                i = 0;
                while (i < arrSource.length && !isFound) {
                    if (arrSource[i].indexOf("=") > 0) {
                        if (arrSource[i].split("=")[0].toLowerCase() == paramName.toLowerCase()) {
                            paramValue = arrSource[i].toLowerCase().split(paramName + "=")[1];
                            paramValue = arrSource[i].substr(paramName.length + 1, paramValue.length);
                            isFound = true;
                        }
                    }
                    i++;
                }
            }
            return paramValue;
        },
        // 修改url指定参数的方法,url,参数名，参数值
        changeURLArg: function (url, arg, arg_val) {
            var pattern = arg + '=([^&]*)';
            var replaceText = arg + '=' + arg_val;
            if (url.match(pattern)) {
                var tmp = '/(' + arg + '=)([^&]*)/gi';
                tmp = url.replace(eval(tmp), replaceText);
                return tmp;
            } else {
                if (url.match('[\?]')) {
                    return url + '&' + replaceText;
                } else {
                    return url + '?' + replaceText;
                }
            }
            return url + '\n' + arg + '\n' + arg_val;
        }
    }//一般工具类结束
};




