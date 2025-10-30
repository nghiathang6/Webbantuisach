<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="QuanLyDonHang.aspx.cs" Inherits="Baitaplonltw.QuanLyDonHang" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Quản lý đơn hàng</title>
    <link href="cssquanlydonhang.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
        <div class="donhang-container">
            <asp:Repeater ID="rptDonHang" runat="server" OnItemDataBound="rptDonHang_ItemDataBound" OnItemCommand="rptDonHang_ItemCommand">
                <HeaderTemplate>
                    <table class="sanpham-table">
                        <tr>
                            <th>Họ tên</th>
                            <th>SĐT</th>
                            <th>Địa chỉ</th>
                            <th>Ngày đặt</th>
                            <th>Sản phẩm</th>
                            <th>Trạng thái</th>
                            <th>Hành động</th>
                        </tr>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td><%# Eval("HoTen") %></td>
                        <td><%# Eval("SoDienThoai") %></td>
                        <td><%# Eval("DiaChi") %></td>
                        <td><%# Eval("NgayDat", "{0:dd/MM/yyyy HH:mm}") %></td>
                        <td>
                            <ul class="sanpham-list">
                                <asp:Repeater ID="rptSP" runat="server">
                                    <ItemTemplate>
                                        <li><%# Eval("Ten") %> - SL: <%# Eval("SoLuong") %> - Giá: <%# Eval("Gia", "{0:N0}") %> đ</li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>
                        </td>
                        <td>
                            <asp:DropDownList ID="ddlTrangThai" runat="server">
                                <asp:ListItem Value="Chờ xử lý" Text="Chờ xử lý"></asp:ListItem>
                                <asp:ListItem Value="Đang giao" Text="Đang giao"></asp:ListItem>
                                <asp:ListItem Value="Hoàn thành" Text="Hoàn thành"></asp:ListItem>
                                <asp:ListItem Value="Hủy" Text="Hủy"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                        <td>
                            <asp:Button ID="btnCapNhat" runat="server" Text="Cập nhật" CommandName="CapNhatTrangThai" CommandArgument='<%# Container.ItemIndex %>' CssClass="update-btn" />
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    </table>
                </FooterTemplate>
            </asp:Repeater>
            <asp:Label ID="lblThongBao" runat="server" ForeColor="Green"></asp:Label>
        </div>
    </form>
</body>
</html>
