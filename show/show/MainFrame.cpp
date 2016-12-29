#include "MainFrame.h"
#include "jpeg_codec.h"

#include <string>
#include <vector>
#include <stdint.h>

#include <gdiplus.h>

extern CAppModule _Module;

CPopWindow::CPopWindow()
{

}

CPopWindow::~CPopWindow()
{

}

LRESULT CPopWindow::OnPaint(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	CPaintDC dc(m_hWnd);
    CRect rect;
    GetClientRect(rect);
    {
        CMemoryDC memDc(dc.m_hDC, dc.m_ps.rcPaint);
        Gdiplus::Graphics g(memDc.m_hDC);
        g.Clear(Gdiplus::Color(255, 178, 178, 178));

        if (m_pBitmap != NULL)
        {
            // 适应窗口显示
            float fx = m_pBitmap->GetWidth() * 1.0f / rect.Width();
            float fy = m_pBitmap->GetHeight() * 1.0f / rect.Height();
            float factor = max(fx, fy);

            int32_t width = m_pBitmap->GetWidth() / factor;
            int32_t height = m_pBitmap->GetHeight() / factor;

            g.DrawImage(m_pBitmap, Gdiplus::RectF((rect.Width() - width) / 2, (rect.Height() - height) / 2, width, height), 0, 0, m_pBitmap->GetWidth(), m_pBitmap->GetHeight(), Gdiplus::UnitPixel);
        }
    }
   
	return 0L;
}

//////////////////////////////////////////////////////////////////////////
CMainFrame::CMainFrame()
{
    m_pBitmap = NULL;
}

CMainFrame::~CMainFrame()
{
    if (m_pBitmap != NULL)
    {
        delete m_pBitmap;
        m_pBitmap = NULL;
    }
}

BOOL CMainFrame::PreTranslateMessage(MSG* pMsg)
{
	return  FALSE;
}

BOOL CMainFrame::OnIdle()
{
	return TRUE;
}

LRESULT CMainFrame::OnCreate(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	RECT rect;
	CMessageLoop* pLoop = _Module.GetMessageLoop();
	pLoop->AddIdleHandler(this);

    GetClientRect(&rect);
    rect.left += 10;
    rect.top += 10;
    rect.right -= 10;
    rect.bottom -= 10;

    _popWindow.Create(m_hWnd, &rect, NULL, WS_CHILD);
    _popWindow.ShowWindow(SW_SHOW);

    std::string filePath = "f:/666667.jpg";
    std::vector<unsigned char> buf;
    int w = 0, h = 0;

    FILE *infile;                 /* source file */
  
    if ((infile = fopen(filePath.c_str(), "rb")) == NULL) {
        fprintf(stderr, "can't open %s\n", filePath.c_str());
        return 0;
    }
    fseek(infile, 0, SEEK_END);
    int size = ftell(infile);
    fseek(infile, 0, SEEK_SET);

    uint8_t *pBuf = (uint8_t *)malloc(size);
    int readSize = fread(pBuf, 1, size, infile);
    fclose(infile);
   
    gfx::JPEGCodec::Decode(pBuf, size, gfx::JPEGCodec::FORMAT_BGRA, &buf, &w, &h);

    free(pBuf);

    // 把bgrA 数据放到dib中 构造hbitmap 然后绘制
    BITMAPINFO bmi = { 0 };
    bmi.bmiHeader.biSize = sizeof(bmi.bmiHeader);
    bmi.bmiHeader.biWidth = w;
    bmi.bmiHeader.biHeight = -h;
    bmi.bmiHeader.biPlanes = 1;
    bmi.bmiHeader.biBitCount = 32;
    bmi.bmiHeader.biCompression = BI_RGB;

    uint8_t* pBufpx = NULL;
    HBITMAP hbmp = ::CreateDIBSection(NULL, &bmi, DIB_RGB_COLORS, (void **)(&pBufpx), NULL, 0);
    if (hbmp)
    {
        memcpy(pBufpx, buf.data(), buf.size());
    }
        
    //定位x = 1920  y = 2880 的点
    int32_t t = 2880 * w * 4 + 2620 * 4;


    uint8_t* pBBBx = pBufpx + t;

    m_pBitmap = Gdiplus::Bitmap::FromHBITMAP(hbmp, NULL);

    //m_pBitmap = Gdiplus::Bitmap::FromFile(_T("f:/66666.jpg"));

    _popWindow.m_pBitmap = m_pBitmap;



	return 0L;
}

LRESULT CMainFrame::OnDestroy(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
	CMessageLoop* pLoop = _Module.GetMessageLoop();
	pLoop->RemoveIdleHandler(this);
	::PostQuitMessage(0);

	bHandled = FALSE;

	return 1L;
}

LRESULT CMainFrame::OnMovied(UINT uMsg, WPARAM wParam, LPARAM lParam, BOOL& bHandled)
{
    bHandled = FALSE;
    RECT rect;
    GetClientRect(&rect);
    rect.left += 10;
    rect.top += 10;
    rect.right -= 10;
    rect.bottom -= 10;

    _popWindow.MoveWindow(&rect);

    return 0;
}