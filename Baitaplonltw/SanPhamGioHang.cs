using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Baitaplonltw
{
    public class SanPhamGioHang
    {
        public string ID { get; set; }
        public string Ten { get; set; }
        public decimal Gia { get; set; }
        public int SoLuong { get; set; }
        public string Anh { get; set; }

        public decimal ThanhTien => Gia * SoLuong;
    }
}