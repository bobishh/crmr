defmodule CryptomirrorWeb.PageControllerTest do
  use CryptomirrorWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "CryptoMirror"
  end
end
