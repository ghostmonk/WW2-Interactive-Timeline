'''
Created on 2010-05-17

@author: ghostmonk
'''
from string import strip, rstrip

def readFile() :
    
    file = open( "timelineConfig_en.xml" );
    isConsecutive = False;
    vetLines = [];
    newFileContent = "";
    
    line = file.readline();
    while line:
        cleanLine = strip( line )
        
        if( cleanLine[ 0:7 ] == "<vet id" ) :
            
            if( vetLines.count( line ) == 0 ) :
                vetLines.append( line );
            
            if( isConsecutive == False ) :
                newFileContent += "\t\t\t<vets>"
                
            id = cleanLine[ 9:13 ];
            
            if( id[ 0:1 ] != "\"" ) :
                newFileContent += cleanLine[ 9:13 ] + " ";
            
            isConsecutive = True;
            
        else :
            
            if( isConsecutive == True ) :
                newFileContent = rstrip( newFileContent );
                newFileContent += "</vets>\n";
            
            isConsecutive = False;
            
            newFileContent += line;
                
        if( cleanLine[ 0:9 ] == "</events>" ) :
            
            newFileContent += "\t\t<vetrans>\n";
            
            for vet in vetLines :
                newFileContent += vet;
            
            newFileContent += "\t\t</vetrans>";

        line = file.readline();
        
    file.close();
    return newFileContent;

newFile = open( "output/timelineConfig_en.xml", "w" );
newFile.write( readFile() );
newFile.close();