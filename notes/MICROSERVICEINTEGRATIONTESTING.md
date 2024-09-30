There are two ways to test structured output data from microservices (such as in json or xml), and you should use both:

Test 1 - Validate against a schema. This one is easy, plenty of tools to help you do that.

Test 2 - Use a tool like BeautifulSoup or an XLST engine to put the response into a graph which is parsable with an XQuery statement which defines exactly the information you care about testing, AND NOTHING ELSE.

--

Using XQuery it is possible to assert on partial structual relationships between elements in a XML graph or JSON graph, so even if the whole rest of the structure changes, if your bit that you care about doesn't, it will identify that bit that you care about, and read the data.

--

Now here is the clever bit - what these test results tell you:

1. If Test 1 fails, there is probably an update to the data service that is providing you data. You want to know about this.
2. If Test 2 fails, your data isn't present in the data service.


* If Test 1 fails and Test 2 passes, there has been an update to the data service that is providing your service data - BUT THEY HAVE RESPECTED THE BIT YOU CARE ABOUT. You probably need to get the new schema and upgrade your parsing code in your own microservice.


* If Test 1 passes and Test 2 fails - the data bits you are looking for aren't there but there has been no update to the structure of the data. Possibly there is a data problem with the query you're requesting.

* If Test 1 passes and Test 2 passes - No update, data still there, no problem, all good.

* If Test 1 fails and Test 2 fails - Likely there has been an update to the service that is feeding you data, AND THEY HAVENT RESPECTED THE BIT YOU CARE ABOUT. Major not good!


So yeah, it seems like a pretty good way of dealing with microservice integration testing to me.


