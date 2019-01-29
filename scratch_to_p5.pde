import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.ServletException;

import java.io.*;
import javax.servlet.*;
import javax.servlet.http.*;

float scratchX;
float scratchY;
float scratchR;

// Booleans to keep track of whether scratch variables have 
// been updated. We should only re-draw once all have been set.
boolean scratchXDirty = false;
boolean scratchYDirty = false;
boolean scratchRDirty = false;

float lastCleanScratchX = scratchX;
float lastCleanScratchY = scratchY;
float lastCleanScratchR = scratchR;

float botX;
float botY;
float botR;

boolean sayHello = false;

void setup(){
  size(480, 360, P2D);
  
  rectMode(CENTER);
  
  textMode(CENTER);
  textAlign(CENTER);
  textSize(48);
  
  try {
    startServer();
  } catch (Exception e){
    println("Exception starting server");
  }
  
  scratchX = 0;
  scratchY = 0;
  
  noStroke();
}

void draw(){
  
  if(mousePressed){
    PVector botV = new PVector(mouseX - botX, mouseY - botY);
    botV.setMag(5);
    
    botX = botX + botV.x;
    botY = botY + botV.y;
    botR = degrees(botV.heading());
  }
    
  translate(width / 2, height / 2);
  
  fill(255, 10);
  rect(0, 0, width, height);
    
  if(sayHello){
    fill(0);
    text("hello", 0, 0);
    sayHello = false;  
  }

  // Flip vertically so the coordinate system matches scratch's.
  scale(1, -1);  

  // Only redraw after all variables have been updated by scratch
  if(scratchXDirty && scratchYDirty && scratchRDirty){  
    scratchXDirty = false;
    scratchYDirty = false;
    scratchRDirty = false;
    
    lastCleanScratchX = scratchX;
    lastCleanScratchY = scratchY;
    lastCleanScratchR = scratchR;    
  }
    
  // Draw the triangle that's controlled by scratch.
  fill(255, 0, 0);
  pushMatrix();
  translate(lastCleanScratchX, lastCleanScratchY);

  float rot = lastCleanScratchR + 360;

  //if(scratchR < 0){
  //  rot += 360;  
  //}
  scale(1, - 1);
  rotate(radians(rot));
  scale(1, - 1);  
  
  beginShape();
  vertex(0, 10);
  vertex(5, -10);
  vertex(-5, -10);
  endShape(CLOSE);
  popMatrix();
  
  fill(0, 255, 0);
  translate(botX - width / 2, -botY + height / 2);
  rotate(radians(-botR));
  rect(0, 0, 20, 20);
}

void startServer() throws Exception
{
  Server server = new Server(20807);

  ServletContextHandler context = new ServletContextHandler(ServletContextHandler.SESSIONS);
  context.setContextPath("/"); 
  context.addServlet(new ServletHolder(new PollResponse()),  "/poll"); 
  context.addServlet(new ServletHolder(new GreetResponse()), "/greet"); 
  context.addServlet(new ServletHolder(new ScratchXResponse()),  "/scratchX/*"); 
  context.addServlet(new ServletHolder(new ScratchYResponse()),  "/scratchY/*"); 
  context.addServlet(new ServletHolder(new ScratchRResponse()),  "/scratchR/*"); 

  ResourceHandler resource_handler = new ResourceHandler();
  resource_handler.setDirectoriesListed(false); 
  resource_handler.setWelcomeFiles(new String[]{ "newhtml.html" }); 
  resource_handler.setResourceBase(sketchPath(".")); 

  HandlerList handlers = new HandlerList();
  handlers.setHandlers(new Handler[] {resource_handler, context, new DefaultHandler() }); 
  server.setHandler(handlers); 

  server.start(); 
}
