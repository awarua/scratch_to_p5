public class PollResponse extends HttpServlet {

  @Override public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/text");
    PrintWriter out = response.getWriter();

    // println(request);
    
    // Map values for slightly different scratch coordinate system.
    float mappedBotX = botX - (width / 2);
    float mappedBotY = -1 * (botY - (height / 2));
    float mappedBotR = botR + 90;
    
    out.println("botX " + mappedBotX + "\n");
    out.println("botY " + mappedBotY + "\n");
    out.println("botR " + mappedBotR + "\n");
  }
}

public class GreetResponse extends HttpServlet {

  @Override public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    println(request);
    
    sayHello = true;

    out.println(simpleHtmlPage("greet"));
  }
}

public class ScratchXResponse extends HttpServlet {

  @Override public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    String strX = request.getPathInfo().split("/")[1];
    scratchX = Float.parseFloat(strX);
    scratchXDirty = true;
    
    println(scratchX);
    
    out.println(simpleHtmlPage("scratchX"));
  }
}

public class ScratchYResponse extends HttpServlet {

  @Override public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    String strY = request.getPathInfo().split("/")[1];
    scratchY = Float.parseFloat(strY);
    scratchYDirty = true;
    
    println(scratchY);
    
    out.println(simpleHtmlPage("scratchY"));
  }
}

public class ScratchRResponse extends HttpServlet {

  @Override public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    response.setContentType("text/html");
    PrintWriter out = response.getWriter();

    String strR = request.getPathInfo().split("/")[1];
    scratchR = Float.parseFloat(strR);
    scratchRDirty = true;
    
    println(scratchR);
    
    out.println(simpleHtmlPage("scratchR"));
  }
}

String simpleHtmlPage(String title) {
  return "<!DOCTYPE html>" + "\n"
    + "<html>\n"
    + "<head><title>" + title + "</title></head>\n"
    + "<body>\n"
    + "<h1>" + title + "</h1>\n"
    + "</body></html>";
}