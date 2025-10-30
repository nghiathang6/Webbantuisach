using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Baitaplonltw
{
    public partial class QuanLyDonHang : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDonHang();
            }
        }

        private void LoadDonHang()
        {
            var dsDonHang = Session["DonHang"] as List<DonHang>;
            if (dsDonHang != null && dsDonHang.Count > 0)
            {
                rptDonHang.DataSource = dsDonHang;
                rptDonHang.DataBind();
                lblThongBao.Text = "";
            }
            else
            {
                lblThongBao.Text = "Chưa có đơn hàng nào.";
            }
        }

        protected void rptDonHang_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                DonHang donHang = (DonHang)e.Item.DataItem;

                Repeater rptSP = (Repeater)e.Item.FindControl("rptSP");
                if (rptSP != null && donHang.SanPham != null)
                {
                    rptSP.DataSource = donHang.SanPham;
                    rptSP.DataBind();
                }

                DropDownList ddlTrangThai = (DropDownList)e.Item.FindControl("ddlTrangThai");
                if (ddlTrangThai != null)
                {
                    ddlTrangThai.SelectedValue = donHang.TrangThai ?? "Chờ xử lý";
                }

                Button btnCapNhat = (Button)e.Item.FindControl("btnCapNhat");
                if (btnCapNhat != null)
                {
                    btnCapNhat.CommandArgument = e.Item.ItemIndex.ToString();
                }
            }
        }

        protected void rptDonHang_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "CapNhatTrangThai")
            {
                int index = Convert.ToInt32(e.CommandArgument);

                var dsDonHang = Session["DonHang"] as List<DonHang>;
                if (dsDonHang != null && index >= 0 && index < dsDonHang.Count)
                {
                    // Lấy DropDownList từ item command
                    DropDownList ddlTrangThai = (DropDownList)e.Item.FindControl("ddlTrangThai");
                    if (ddlTrangThai != null)
                    {
                        dsDonHang[index].TrangThai = ddlTrangThai.SelectedValue;
                        Session["DonHang"] = dsDonHang;  // lưu lại session
                        lblThongBao.Text = $"Cập nhật trạng thái đơn hàng của {dsDonHang[index].HoTen} thành công.";
                        LoadDonHang();
                    }
                }
            }
        }
    }
}
