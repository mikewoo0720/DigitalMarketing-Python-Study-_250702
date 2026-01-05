// ==== 1. 책 데이터 로드 & 렌더링 ====
// 만약 api가 여러개가 될 경우 객체형태(딕셔너리)로 가져와야함.
const API_URL =
  "https://raw.githubusercontent.com/mikewoo0720/finalProject_api/refs/heads/main/books_yes24.json";

let allBooks = [];

async function loadBooks() {
  try {
    const res = await fetch(API_URL);
    allBooks = await res.json();
    renderBooks(allBooks);
    console.log(allBooks);
  } catch (error) {
    console.error("책 데이터를 불러오는 중 오류가 발생했습니다:", error);
  }
}

function renderBooks(books) {
  const listEl = document.getElementById("bookList");
  listEl.innerHTML = "";
  books.forEach((book) => {
    const card = document.createElement("article");
    card.className = "book-card";
    const url = book.detail_url || "#";
    card.innerHTML = `
      <a href="${url}" target="_blank" rel="noopener noreferrer">
        <img src="${book.thumbnail || ""}" alt="${book.title || ""}" />
      </a>
      <h3>
        <a href="${url}" target="_blank" rel="noopener noreferrer">
          ${book.title || "제목 없음"}
        </a>
      </h3>
      <p class="meta">${book.author || "저자 미상"} | ${
      book.publisher || ""
    }</p>
      <p class="meta">정가: ${book.list_price || "-"} / 판매가: ${
      book.sale_price || "-"
    }</p>
      <p class="meta">카테고리: ${book.category || ""} | 재고: ${
      book.stock || ""
    }</p>
      <button type="button">댓글 보기</button>
    `;
    const btn = card.querySelector("button");
    btn.addEventListener("click", () => openCommentSection(book));
    listEl.appendChild(card);
  });
}

loadBooks();
