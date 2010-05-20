'''
Created on 2010-05-18

@author: ghostmonk
'''
from string import strip

def printDict( data ):
    for id, value in data.iteritems():
        print id + " : " + value;


def isCustomLink( testURL ):
    test = testURL[ 0:4 ];
    return test == "http" or test == "www."

def getVetNode( data ):
    vetNode = '            <vet ';
    attribName = 'customLink' if isCustomLink( data[ 'vetID' ] ) else 'id';
    vetNode += attribName + '="' + data[ 'vetID' ].replace( "&", "&amp;" ) + '">' + data[ 'vetName' ] + '</vet>\n'
    return vetNode;

def getEventNode( data ):
    output = '\n        <event date="' + data[ 'date' ] + '" ';
    
    attribName = 'customImgLink' if isCustomLink( data[ 'img' ] ) else 'img';
    output += attribName + '="' + data[ 'img' ] + '">\n';
    
    output += '            <text>' + data[ 'text' ] + '</text>\n';
    output += getVetNode( data );
    return output;

def getXMLNode( data ):
    
    eventDict = {};
    eventDict[ 'date' ] = strip( data[0] ); 
    eventDict[ 'text' ] = strip( data[1] );
    eventDict[ 'img' ] = strip( data[2] );
    eventDict[ 'vetName' ] = strip( data[3] );
    eventDict[ 'vetID' ] = strip( data[4] );
    
    isVetNode = eventDict[ 'date' ] == "" and eventDict[ 'text' ] == "" and eventDict[ 'img' ] == "" and not eventDict[ 'vetName' ] == "" and not eventDict[ 'vetID' ] == "";
    isEmpty = not isVetNode and eventDict[ 'img' ] == "";
    isCusLink = isCustomLink( eventDict[ 'img' ] );
    isBadVetID = isCustomLink( eventDict[ 'vetID' ] );
    isEmptyName = eventDict[ 'vetName' ] == "";
    
    if isEmpty or isCusLink or isBadVetID or isEmptyName:
        return ( 3, eventDict );
    
    if isVetNode:
        return ( 1, getVetNode( eventDict ) );
    elif eventDict[ 'date' ] == 'Date':
        return ( 2, '' );
    else :
        return ( 0, getEventNode( eventDict ) );

def cleanLine( line ) :
    output = strip( line );
    output = output.replace( "http://www.thememoryproject.com/Stories/Veteran-Profile.aspx?itemid=", "" );
    output = output.replace( "http://www.thememoryproject.com/VeteranAssets/Artifact/Thumb_Small/", "" );
    return output;

def readFile():
    
    badDataCollector = [];
    parsedFile = "";
    openNode = "";
    eventNodeClose = '        </event>\n';
    isFirst = True;
    eventCount = 0;
    vetCount = 0;
    rawFile = open("Timeline_may18~.txt", "rb");
    
    for line in rawFile:
        line = cleanLine( line ) + "\n";
        lineData = line.split( "~" );
        if len( lineData ) == 6 : lineData.pop();
        xmlTuple = getXMLNode( lineData );
        type = xmlTuple[ 0 ];
        
        if type == 0:
            eventCount += 1;
            if not isFirst : 
                openNode += eventNodeClose;
            isFirst = False;
            parsedFile += openNode;
            openNode = xmlTuple[ 1 ];
        elif type == 1:
            vetCount += 1;
            openNode += xmlTuple[ 1 ];
        elif type == 3:
            printDict( xmlTuple[ 1 ] );
            badDataCollector += xmlTuple[ 1 ];
    
    
    print eventCount;
    print vetCount;
    return parsedFile;

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