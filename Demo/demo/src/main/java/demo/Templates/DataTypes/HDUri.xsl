<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         This template follows FHIR-Converter DataType/HDUri
         TODO: replace space (' ') with dash ('-') where specified
         xsl:replace behaves strangely
         
    -->
    
    <xsl:template name="HDUri">
        <xsl:param name="curr"/>
            <xsl:choose>
                <xsl:when test="($curr/hl7:HD.1 and not($curr/hl7:HD.2))
                    or ($curr/hl7:HD.2='' and not($curr/hl7:HD.3))
                    or $curr/hl7:HD.3=''">
                    <string key="system">http://example.com/v2-to-fhir-converter/Identifier/<xsl:value-of select="$curr/hl7:HD.1"/></string> <!-- replace ' ' with '-' -->
                </xsl:when>
                <xsl:when test="$curr/hl7:HD.3='ISO' or $curr/hl7:HD.3='CLIA' or $curr/hl7:HD.3='CLIP'">
                    <string key="system">urn:oid:<xsl:value-of select="$curr/hl7:HD.2"/></string>
                </xsl:when>
                <xsl:when test="$curr/hl7:HD.3='UUID' or $curr/hl7:HD.3='GUID'">
                    <string key="system">urn:uuid:<xsl:value-of select="$curr/hl7:HD.2"/></string>
                </xsl:when>
                <xsl:otherwise>
                    <string key="system">http://example.com/v2-to-fhir-converter/Identifier/<xsl:value-of select="$curr/hl7:HD.3"/></string> <!-- replace ' ' with '-' -->
                </xsl:otherwise>
            </xsl:choose>
    </xsl:template>
</xsl:stylesheet>