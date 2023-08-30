import puppeteer from "puppeteer";
import {getDocument, queries} from "pptr-testing-library";

const url = process.argv[2];
if (!url) {
    console.error('Please provide a URL as the first parameter.');
    process.exit(1);
}

(async () => {
    const browser = await puppeteer.launch({ headless: true });
    const page = await browser.newPage();
    await page.goto(url);
    const document = await getDocument(page);
    await queries.findByText(document,/Backend server is UP/);
    await browser.close();
})();
