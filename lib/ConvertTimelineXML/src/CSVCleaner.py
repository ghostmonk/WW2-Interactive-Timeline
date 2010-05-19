'''
Created on 2010-05-18

@author: ghostmonk
'''
from string import strip

def isCustomLink( testURL ):
    test = testURL[0:4];
    return test == "http" or test == "www."

def getVetNode( data ):
    vetNode = '            <vet ';
    attribName = 'customLink' if isCustomLink( data[ 'vetID' ] ) else 'id';
    vetNode += attribName + '="' + data[ 'vetID' ].replace( "&", "&amp;" ) + '">' + data[ 'vetName' ] + '</vet>\n'
    return ( 1, vetNode );

def getEventNode( data ):
    output = '\n        <event date="' + data[ 'date' ] + '" ';
    
    attribName = 'customImgLink' if isCustomLink( data[ 'img' ] ) else 'img';
    output += attribName + '="' + data[ 'img' ] + '">\n';
    
    output += '            <text>' + data[ 'text' ] + '</text>\n';
    output += getVetNode( data )[ 1 ];
    return ( 0, output );

def getXMLNode( data ):
    
    eventDict = {};
    eventDict[ 'date' ] = strip( data[0] ); 
    eventDict[ 'text' ] = strip( data[1] );
    eventDict[ 'img' ] = strip( data[2] );
    eventDict[ 'vetName' ] = strip( data[3] );
    eventDict[ 'vetID' ] = strip( data[4] );
    
    if eventDict[ 'date' ] == "" and eventDict[ 'text' ] == "" and eventDict[ 'img' ] == "" :
        return getVetNode( eventDict );
    if eventDict[ 'date' ] == 'Date':
        return ( 3, '' );
    else :
        return getEventNode( eventDict );

def cleanLine( line ) :
    output = strip( line );
    output = output.replace( "http://www.thememoryproject.com/Stories/Veteran-Profile.aspx?itemid=", "" );
    output = output.replace( "http://www.thememoryproject.com/VeteranAssets/Artifact/Thumb_Small/", "" );
    return output;

def readFile():
    
    parsedFile = "";
    
    openNode = "";
    closeEventNode = '        </event>\n';
    
    rawFile = open("Timeline_may18~.txt", "rb");
    count = 0;
    
    for line in rawFile:
        line = cleanLine( line ) + "\n";
        lineData = line.split( "~" );
        if len( lineData ) == 6 : lineData.pop();
        xmlTuple = getXMLNode( lineData );
        type = xmlTuple[ 0 ];
        
        if type == 0:
            count += 1;
            openNode = closeEventNode;
            
        if not type == 3:
            openNode += xmlTuple[ 1 ];   
            parsedFile += openNode;
           
    return parsedFile + closeEventNode;

outputHeader = """<?xml version="1.0" encoding="UTF-8"?>
<timelineData>

    <links>
        <smallThumb url="http://www.thememoryproject.com/VeteranAssets/Artifact/Thumb_Small/" />
        <vetProfile url="http://www.thememoryproject.com/Stories/Veteran-Profile.aspx?itemid=" />
    </links>
    
    <events>
"""
outputFooter = """
    </events>
    
</timelineData>"""

cleanFile = open( "timelineConfig_en.xml", "w" );
cleanFile.write( outputHeader );
cleanFile.write( readFile() );
cleanFile.write( outputFooter );
cleanFile.close();