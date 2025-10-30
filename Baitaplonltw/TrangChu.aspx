<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="TrangChu.aspx.cs" Inherits="Baitaplonltw.WebForm1" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Trang chu</title>
    <link href="trangchu.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server">
         <div class="wrapper">
            <div class="header-container">
                <a href="TrangChu.aspx">
                    <img src="icon/logo2.png" alt="logo" width="60px" style="margin-left:30px"/>
                </a>
                <asp:TextBox ID="txtTuKhoa" runat="server" CssClass="o-tim-kiem" Placeholder="Tìm kiếm..." onkeyup="searchProducts(this.value)" AutoComplete="off" />
                <div id="searchResults" style="position:absolute; display:none; background:white; border:1px solid #ccc; max-height:300px; overflow-y:auto; width:300px; z-index:1000;"></div>
                <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePageMethods="true" />
                
                <div class="hang-text">
                    <span class="clickable-text" onclick="window.location.href='Tuideocheo.aspx'">Túi đeo chéo</span>
                    <span class="clickable-text" onclick="window.location.href='Tuideovai.aspx'">Túi đeo vai</span>
                    <span class="clickable-text" onclick="window.location.href='Tuixachtay.aspx'">Túi xách tay</span>
                    <span class="clickable-text" onclick="window.location.href='Donhang.aspx'">Đơn hàng</span>
                </div>
                <a href="Giohang.aspx">
                    <img src="icon/cart.png" alt="cart" width="40px" style="margin-left:40px;margin-top:10px"/>
                </a>

                <div class="user-menu">
                    <img src="icon/user.png" alt="User" class="user-icon" onclick="toggleMenu()" />
                    <div id="dropdown" class="dropdown-menu">
                        <a href="Dangnhap.aspx">Đăng nhập</a>
                        <a href="Dangky.aspx">Đăng ký</a>
                    </div>
                </div>
                <asp:Label ID="lblChao" runat="server" class="xinchao"/>
            </div>
            <div style="text-align: center; margin-top: 30px;">
                <img src="/icon/panel.jpg" alt="panel" width="1400px" />
            </div>

             <div class="banner3">
                <div>
                    <asp:Image ID="imgBanner1" runat="server" ImageUrl="~/3banner/anh1.jpg" AlternateText="Banner1" CssClass="banner3-img" />
                    <p class="banner3-text">BUBBLY</p>
                    <p class="banner3-more">XEM CHI TIẾT</p>
                </div>
                <div>
                    <asp:Image ID="imgBanner2" runat="server" ImageUrl="~/3banner/anh2.jpg" AlternateText="Banner2" CssClass="banner3-img" />
                    <p class="banner3-text">TIDY</p>
                    <p class="banner3-more">XEM CHI TIẾT</p>
                </div>
                <div>
                    <asp:Image ID="imgBanner3" runat="server" ImageUrl="~/3banner/anh3.jpg" AlternateText="Banner3" CssClass="banner3-img" />
                    <p class="banner3-text">NEUTRAL</p>
                    <p class="banner3-more">XEM CHI TIẾT</p>
                </div>
            </div>
             
            <div class="middle-banner">
                <div class="left-content">
                    <img src="icon/panner2.jpg" alt="banner2" />
                </div>
                <div class="right-content">
                    <h4 class="section-title">FEEL LIGHT, LIVE MORE</h4>
                    <hr />
                    <h4 style="font-size:13px;">ON CLOUD NINE | HAPAS x VŨ CÁT TƯỜNG - BÍ ĐỎ</h4>
                    <p class="right-text">
                        <em>HAPAS</em> từng nghĩ: phải cố gắng thật nhiều thì mới đáng sống.
                        Nhưng rồi nhận ra, có những ngày thật đẹp lại bắt đầu bằng cảm giác
                        <strong>“nhẹ”</strong>: nhẹ lòng, nhẹ bước, nhẹ nhàng được là chính mình.
                    </p>
                    <p class="right-text">
                        Và đó cũng là hành trình mà BST <strong>ON CLOUD NINE</strong> gửi gắm.
                        Một sự kết hợp giữa <strong>HAPAS</strong> cùng <strong>VŨ CÁT TƯỜNG & BÍ ĐỎ</strong>,
                        nơi những câu chuyện rất riêng được viết nên bằng ánh nhìn, bằng sự thấu hiểu
                        và bằng những lựa chọn mang tên <strong>“xúc cảm”</strong>.
                    </p>
                    <p class="right-text">
                        Không phải để nổi bật, mà để được là chính mình.<br />
                        Không phải để chứng tỏ, mà để yêu thương nhẹ nhàng hơn.
                    </p>
                    <p class="right-text">
                        <em>HAPAS</em> hi vọng bạn sẽ tìm thấy đâu đó trong BST lần này một cảm giác
                        để sống chậm lại, sống thật hơn & sống nhiều hơn.
                    </p>

                    <asp:Repeater ID="rptHaiAnh" runat="server">
                        <ItemTemplate>
                            <div class="double-img">
                                <div class="anh-item">
                                    <a href='<%# "Chitiet.aspx?id=" + Eval("ID1") %>'>
                                        <img src='<%# Eval("Anh1") %>' class="anh-200" />
                                    </a>
                                    <p class="ten-anh"><%# Eval("Ten1") %></p>
                                </div>
                                <div class="anh-item">
                                    <a href='<%# "Chitiet.aspx?id=" + Eval("ID2") %>'>
                                        <img src='<%# Eval("Anh2") %>' class="anh-200" />
                                    </a>
                                    <p class="ten-anh"><%# Eval("Ten2") %></p>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>

             <hr style="width:1400px;align-items:baseline;color:gray; " />

             <div class="typeprod">
                 <h4>Túi đeo chéo</h4>
                 <a style="color:#20265b;margin-left:20px;" href="Tuideocheo.aspx">XEM THêM></a>
             </div>

             <div class="product-container">
                <asp:Repeater ID="rptbontdc" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <a href='<%# "Chitiet.aspx?id=" + Eval("ID") %>'>
                                <img src='<%# Eval("Anh") %>' alt="Ảnh" class="product-img" />
                            </a>
                            <div class="product-name"><%# Eval("Ten") %></div>
                            <div class="product-price"><%# Eval("Gia", "{0:N0}") %> đ</div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                 </div>


             <div class="typeprod">
                 <h4>Túi đeo vai</h4>
                 <a style="color:#20265b;margin-left:20px;" href="Tuideovai.aspx">XEM THêM></a>
             </div>

             <div class="product-container">
                <asp:Repeater ID="rptbontdv" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <a href='<%# "Chitiet.aspx?id=" + Eval("ID") %>'>
                                <img src='<%# Eval("Anh") %>' alt="Ảnh" class="product-img" />
                            </a>
                            <div class="product-name"><%# Eval("Ten") %></div>
                            <div class="product-price"><%# Eval("Gia", "{0:N0}") %> đ</div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
             </div>


             <div class="typeprod">
                 <h4>Túi xách tay</h4>
                 <a style="color:#20265b;margin-left:20px;" href="Tuixachtay.aspx">XEM THêM></a>
             </div>

             <div class="product-container">
                <asp:Repeater ID="rptbontxt" runat="server">
                    <ItemTemplate>
                        <div class="product-card">
                            <a href='<%# "Chitiet.aspx?id=" + Eval("ID") %>'>
                                <img src='<%# Eval("Anh") %>' alt="Ảnh" class="product-img" />
                            </a>
                            <div class="product-name"><%# Eval("Ten") %></div>
                            <div class="product-price"><%# Eval("Gia", "{0:N0}") %> đ</div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
             </div>


             
        </div>
        
        
    </form>
    <script>
        let timeout = null;

        function searchProducts(keyword) {
            clearTimeout(timeout);
            const resultsDiv = document.getElementById("searchResults");

            if (keyword.trim() === "") {
                resultsDiv.innerHTML = "";
                resultsDiv.style.display = "none"; // Ẩn khi không có keyword
                return;
            }

            timeout = setTimeout(() => {
                fetch("TrangChu.aspx/SearchProducts", {
                    method: "POST",
                    headers: {
                        "Content-Type": "application/json; charset=utf-8"
                    },
                    body: JSON.stringify({ keyword: keyword })
                })
                    .then(res => res.json())
                    .then(data => {
                        const products = data.d;
                        let html = "";
                        if (products && products.length > 0) {
                            products.forEach(item => {
                                html += `<div style="padding:5px; border-bottom:1px solid #ddd; display:flex; align-items:center; cursor:pointer;" onclick="goToDetail('${item.ID}')">
                                <img src="${item.Anh}" alt="${item.Ten}" style="width:50px; height:50px; object-fit:cover; margin-right:10px;" />
                                <span>${item.Ten}</span>
                            </div>`;
                            });
                            resultsDiv.innerHTML = html;
                            resultsDiv.style.display = "block"; // Hiện khi có kết quả
                        } else {
                            resultsDiv.innerHTML = "<div style='padding:10px;'>Không tìm thấy sản phẩm</div>";
                            resultsDiv.style.display = "block"; // Vẫn hiện khi không có sản phẩm
                        }
                    })
                    .catch(err => {
                        console.error(err);
                        resultsDiv.style.display = "none";
                    });
            }, 300);
        }

        function goToDetail(id) {
            window.location.href = `Chitiet.aspx?id=${id}`;
        }

        // Ẩn kết quả tìm kiếm khi click ra ngoài
        document.addEventListener("click", function (e) {
            var searchDiv = document.getElementById("searchResults");
            var txtBox = document.getElementById("<%= txtTuKhoa.ClientID %>");
        if (!searchDiv.contains(e.target) && e.target !== txtBox) {
            searchDiv.innerHTML = "";
            searchDiv.style.display = "none";
        }
    });
    </script>
    <script>
    function toggleMenu() {
        var menu = document.getElementById("dropdown");
        menu.style.display = menu.style.display === "block" ? "none" : "block";
    }

    // Tự động đóng menu khi click ra ngoài
    window.onclick = function(event) {
        if (!event.target.matches('.user-icon')) {
            var menu = document.getElementById("dropdown");
            if (menu && menu.style.display === "block") {
                menu.style.display = "none";
            }
        }
    };
    </script>
</body>
</html>
