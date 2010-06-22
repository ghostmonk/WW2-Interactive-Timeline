from string import strip

outfile = "vetrans_fr.xml";
infile = "FRVetrans_June13~.txt";

def cleanLine( line ) :
    output = strip( line );
    output = output.replace( "http://www.thememoryproject.com/stories/veteran-profile.aspx?itemid=", "" );
    output = output.replace( "http://www.thememoryproject.com/Stories/Veteran-Profile.aspx?itemid=", "" );
    output = output.replace( "http://www.thememoryproject.com/VeteranAssets/Artifact/Thumb_Small/", "" );
    return output;

def readFile():
    
    parsedFile = "";
    rawFile = open(infile, "rb");
    
    for line in rawFile:
        line = cleanLine( line ) + "\n";
        lineData = line.split( "~" );
        
        vetID = strip( lineData[0] );
        fName = strip( lineData[1] );
        lName = strip( lineData[2] );
        date = strip( lineData[3] ); 
        text = strip( lineData[4] );
        img = strip( lineData[5] );
        
        node = '\n        <veteran date="' + date + '" ' + 'img="' + img + '">';
        node += '\n            <text>' + text + '</text>';
        node += '\n            <vet id="' + vetID + '">' + fName + ' ' + lName + '</vet>';
        node += '\n        </veteran>\n'
        
        parsedFile += node;
    
    return parsedFile;

cleanFile = open( outfile, "w" );
cleanFile.write( readFile() );
cleanFile.close();