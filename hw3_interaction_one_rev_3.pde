//Soucrces: https://www.geeksforgeeks.org/breadth-first-search-or-bfs-for-a-graph/
//Sources: https://docs.google.com/presentation/d/1_PFcKPQS5BDTEpIdGvDIW9M-vm2EWYxohHyCRSrWw1M/edit#
//Sources: BFS code from class
//Sources: Line Intersection code from class
//Sources: https://www.youtube.com/watch?v=mhjuuHl6qHM
//https://www.red3d.com/cwr/boids/

//the main agent does not avoid the obstacles once it reaches the goal.

float steeringx;
float steeringy;
float avglocx;
float avglocy;
int radiusOfPercep = 500;//250;//50;  //align for radius within this distance

AGENT[] agent1; //stores agents                                  //if the radius of perception is the size of the canvas then the boids start having the same velocity
CIRCLE upperLeft;
CIRCLE lowerRight;

int numAgents =  5; //1;// 5; //15; //5; //1; //5; //1; //100; //3; //50; //10; //10; //100;

float agentxposit = 150;
float agentyposit = 650;

float goalx = 650;
float goaly = 150;
int radius = 100;
int agentAndTargetRadius = 25;
float xsphere = 400;
float ysphere = 400;


float xpoint;
float ypoint;
//int numpoints = 13; //first two elements are agents; the last 1 elment is the goal. The other 10 are the nodes //play around with num of points; more points leads to possibility of finding the ideal path
int numpoints =  15; //25;//10; //50; //30;//10;//5; //25; //These make up the "pit stops"  // 10 gives 9 sample points because we store the goal in one of the slotes.
float[] xpoints = new float[numpoints]; 
float[] ypoints = new float[numpoints]; 


void setup(){
    size(800, 800, P3D);
    agent1 = new AGENT[numAgents];
    upperLeft = new CIRCLE(150, 150, 300, #0FBF80); //green
    lowerRight = new CIRCLE(600, 600, 400, #1FA5CB); //blue
    
    findpoints();
   
     print("xpoints:");
     printArray(xpoints);
  
     println( "ypoints:");
     printArray(ypoints);
   
    for(int i = 0; i < numAgents; i++){
      
     if(i == 0){
        agent1[i] = new AGENT(xpoints, ypoints, agentxposit, agentyposit);
     }
     //agent1[i] = new AGENT(xpoints, ypoints, 50 + i*25 , 700 + i*25);
      //agent1[i] = new AGENT(xpoints, ypoints, random(width), random(height));
      //agent1[i] = new AGENT(random(width), random(height));

      //agent1[i] = new AGENT(xpoints, ypoints, random(0,600), random(0, 600));
      //agent1[i] = new AGENT(xpoints, ypoints, random(50,400), random(400, 750));
      else{
          agent1[i] = new AGENT(xpoints, ypoints, random(50,100), random(650, 750));
      }

      //agent1[i] = new AGENT(xpoints, ypoints, 50, 750);

  if(i == 0){
    agent1[i].bfs();
    agent1[i].nextNode = agent1[i].path.size()-2;
    agent1[i].c = #1C0A07;
  }
  

}
}

void draw() {

        background(255, 255, 255);
        
  
        // flocking and other updates
        for(int i = 0; i < numAgents; i++){
            agent1[0].edges();
            if(i>0){ 
              //agent1[i].edges();
              align(agent1[i]); 
              cohesion(agent1[i]);
              separation(agent1[i]);
              agent1[i].updateposit(1/frameRate);
            }
            //agent1[i].updateposit(1/frameRate);
           
            if(i == 0){
              
              // align(agent1[i]); 
             // cohesion(agent1[i]);
              separation(agent1[i]);
              agent1[i].updateposit(1/frameRate);
              agent1[i].updatevelocity(1/frameRate, agent1[i].nextNode);
            }
            //agent1[i].updateposit(1/frameRate, agent1[i].nextNode);
      
        }
        
         
        //draw the sphere
        pushMatrix();
        fill(0, 0, 255);
        circle(xsphere, ysphere, radius);
        popMatrix();
        
        //draw upperleft obstacle
        pushMatrix();
        fill(upperLeft.c);
        circle(upperLeft.xp, upperLeft.yp, upperLeft.radius);
        popMatrix();
        
        
        //draw lowerRige obstacle
        pushMatrix();
        fill(lowerRight.c);
        circle(lowerRight.xp, lowerRight.yp, lowerRight.radius);
        popMatrix();
        
        

        //draw the agents red
        for(int i = 0; i < numAgents; i ++){
             
            pushMatrix();
            //fill(255, 0, 0);
            fill(agent1[i].c);
            translate(agent1[i].xP, agent1[i].yP);
            circle(0,0, agentAndTargetRadius*.5);
            popMatrix();
       }
       
        //draw the starting points black
        for(int i = 0; i < numAgents; i ++){
             
            pushMatrix();
            fill(0, 0, 0);
            circle(agent1[i].startx, agent1[i].starty, agentAndTargetRadius);
            //circle(0,0, agentAndTargetRadius*.5);
            popMatrix();
       }
       
       //draw the sampled points
       
        for (int i = 0; i < numpoints-1; i++) {
              
            pushMatrix();
            if(i == 1){
              fill(#F02C74); //pink
            }
            else if(i == 2){
              fill(#2CF03A); //green
            }
            else if(i == 3){
              fill(#F0C62C); //yellow
            } 
            else{
              fill(0,0,255); //blue
            }
            circle(xpoints[i], ypoints[i], agentAndTargetRadius*.5);
            popMatrix();
        
      
     }  
       
       
        //Draw the Goal
        pushMatrix();
        fill(0, 255, 0);
        circle(goalx, goaly, agentAndTargetRadius);
        popMatrix();
        
        //Draw the start
        pushMatrix();
        fill(0, 255, 0);
        circle(50, 750, agentAndTargetRadius);
        popMatrix();
        
        
        //draw the paths
        
         // draw the paths
  //for(int h = 0; h < numAgents; h++){
  //      for (int i = 0; i < numpoints; i++)
  //      {
      
          
  //          //for (int j = 0; j < agent1[0].neighbors[i].size(); j++)
  //         for (int j = 0; j < agent1[h].neighbors[i].size(); j++)
  //          {
             
  //            if(h == 0){
  //               pushMatrix();
  //               fill(200);
  //               line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  //               popMatrix();
  //            }
  //            else{
  //               pushMatrix();
  //               fill(100);
  //               line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  //               popMatrix();
  //            }  
  //            //line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  
  //            //line(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agent1[0].arrayofXpoints[agent1[0].neighbors[i].get(j)], agent1[0].arrayofYpoints[agent1[0].neighbors[i].get(j)]);
            
  //        }

  //     }
  //} 
  

 
  //draw the paths for when one agent is the leader;
          //   for (int i = 0; i < agent1[0].neighbors[i].size(); i++)
          //  {
             
          //    //if(h == 0){
          //       pushMatrix();
          //       fill(200);
          //       line(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agent1[0].arrayofXpoints[agent1[0].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
          //       popMatrix();
          //    //}
          //    //else{
          //    //   pushMatrix();
          //    //   fill(100);
          //    //   line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
          //    //   popMatrix();
          //    //}  
          //    //line(agent1[h].arrayofXpoints[i], agent1[h].arrayofYpoints[i], agent1[h].arrayofXpoints[agent1[h].neighbors[i].get(j)], agent1[h].arrayofYpoints[agent1[h].neighbors[i].get(j)]);
  
          //    //line(agent1[0].arrayofXpoints[i], agent1[0].arrayofYpoints[i], agent1[0].arrayofXpoints[agent1[0].neighbors[i].get(j)], agent1[0].arrayofYpoints[agent1[0].neighbors[i].get(j)]);
            
          //}
  
  
  
  
}//draw


////this finds the points and includes the goal in the last index
void findpoints() {
  
  xpoints[numpoints-1] = goalx;
  ypoints[numpoints-1] = goaly;  
   
 for (int i = 0; i < numpoints-1; i++)
  { 
   xpoint = random(0, 800);
   ypoint = random(0, 800);
  

   while((xpoint - xsphere)*(xpoint - xsphere) + (ypoint - ysphere)*(ypoint - ysphere) <= (radius)*(radius)||
   (xpoint - upperLeft.xp)*(xpoint - upperLeft.xp) + (ypoint - upperLeft.yp)*(ypoint - upperLeft.yp) <= (upperLeft.radius)*(upperLeft.radius)||
   (xpoint - lowerRight.xp)*(xpoint - lowerRight.xp) + (ypoint - lowerRight.yp)*(ypoint - lowerRight.yp) <= (lowerRight.radius)*(lowerRight.radius))
    {
         xpoint = random(0, 800);
         ypoint = random(0, 800);
      
    }

    xpoints[i] = xpoint;
    ypoints[i] = ypoint;;   

}

}


float distance(float x, float y, float u, float v)
{
  
 return sqrt((x-u)*(x-u) + (y-v)*(y-v));
  
}
              
void align(AGENT agent){
        //int radiusOfPercep = 100;  //align for radius within this distance
        float xavg = 0;
        float yavg = 0;
        int total = 0;
        agent.xAcc = 0;
        agent.yAcc= 0;
        
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
    
                xavg += agent1[i].vx;
                yavg += agent1[i].vy;
                total++;
              }             
        }  
        
       if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
             
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;
       }
        //println("the agvg is:", xavg, yavg); 
        agent.xAcc = steeringx;
        agent.yAcc = steeringy;
        
}

//cohesion is the same concept as align, but it uses position instead of velocity
void cohesion(AGENT agent){
        ////int radiusOfPercep = 100;  //align for radius within this distance

        float xavg = 0;
        float yavg = 0;
        int total = 0;
        
        for(int i = 0; i < numAgents; i++){
        // try with first agent first     
        //if( distance(agent1[0].xP, agent1[0].yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep){
            if( distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP) <= radiusOfPercep ){
    
                xavg += agent1[i].xP;
                yavg += agent1[i].yP; 
                total++;
              }             
        }  
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.xP;
            steeringy = yavg - agent.yP;

        }
     
        agent.xAcc += steeringx;
        agent.yAcc += steeringy;
  
}

void separation(AGENT agent){
  
      float xavg = 0;
      float yavg = 0;
      int total = 0;

      float d;
      for(int i = 0; i < numAgents; i++){
           d = distance(agent.xP, agent.yP, agent1[i].xP, agent1[i].yP); 
           if( d <= radiusOfPercep && agent != agent1[i]){
           //if( d <= radiusOfPercep){
                      float diffx;
                      float diffy;    
                      //the strength of the force should be proportional to the distance. That is, a boid should work harder to 
                      //stay away from a closer boid than a farther boid.
                      diffx = (agent.xP - agent1[i].xP)/d; 
                      diffy = (agent.yP - agent1[i].yP)/d;

                      xavg += diffx;
                      yavg += diffy;
  
                      total++;      
         }    
        // the separation from the sphere used to be in the for loop      
      }
      
   
      d = distance(agent.xP, agent.yP, xsphere, ysphere);
      //if(d < 75 && agent.atEnd == true){
      if(d < radius + 10){
      //if(d <= radiusOfPercep){  
                float diffx;
                float diffy; 
                
                diffx = (agent.xP - xsphere);
                diffy = (agent.yP - ysphere);

                xavg += diffx;
                yavg += diffy;

                total++;
          
        }
        
      
        
      //if(distance(agent.xP, agent.yP, upperLeft.xp, upperLeft.yp) < 400 && agent.atEnd == true)  
      d = distance(agent.xP, agent.yP, upperLeft.xp, upperLeft.yp);
     if(d <= upperLeft.radius + 10){  
     // if(d <= radiusOfPercep){  
                float diffx;
                float diffy; 
                
                diffx = (agent.xP - upperLeft.xp)/d; 
                diffy = (agent.yP - upperLeft.yp)/d;
        
                xavg += diffx;
                yavg += diffy;
        
                total++;
          
        }
        
      d = distance(agent.xP, agent.yP, lowerRight.xp, lowerRight.yp);
      if(d <= lowerRight.radius + 10)
     // if(d <= radiusOfPercep)
      {
                float diffx;
                float diffy; 
                
                diffx = (agent.xP - upperLeft.xp)/d; 
                diffy = (agent.yP - upperLeft.yp)/d;
        
                xavg += diffx;
                yavg += diffy;
        
                total++;
          
        }
        
        if(total > 0){
            xavg = xavg/(total);
            yavg = yavg/(total);
        
            steeringx = xavg - agent.vx;
            steeringy = yavg - agent.vy;        
        }

        //agent.xAcc += 50*(steeringx);
        //agent.yAcc += 50*(steeringy);
        
                agent.xAcc += (25*steeringx);
        agent.yAcc += 25*(steeringy);
        //radiusOfPercep = 500;
      
}
