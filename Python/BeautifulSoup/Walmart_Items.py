from bs4 import BeautifulSoup 
import requests 
page = requests.get("http://www.walmart.com/ip/46716301?athcpid=46716301&athena=true&athpgid=athenaHomepage&athznid=ItemCarouselCurated_contentZone8") 
soup = BeautifulSoup(page.content) 
#links = soup.findAll("li")
for link in soup.findAll("li",{"button"}):
    print link
