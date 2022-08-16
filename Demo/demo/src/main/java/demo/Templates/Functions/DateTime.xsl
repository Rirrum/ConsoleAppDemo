<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:hl7="urn:hl7-org:v2xml"
                xmlns:foo="http://whatever"
                xmlns="http://www.w3.org/2005/xpath-functions">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Preliminary Date/Time formatting function
         This should be replaced with C# code as soon as possible.
         Function doesn't handle several input formats and in general
         the time investment to handle date/time formatting in XSLT
         is not worth it when assemblies will be supported soon
         
         Call from template with: 
         <xsl:call-template name="DateTime">
         <xsl:with-param name="date" select="{path to datetime input}"/>
         </xsl:call-template>
         
    -->
    
    <!-- insert description here -->
    <xsl:function name="foo:handleDate"> 
        <xsl:param name="datetime"/>
        <xsl:variable name="date">
            <xsl:value-of select="substring($datetime, 1, 4)"/>-<xsl:value-of select="substring($datetime,5,2)"/>-<xsl:value-of select="substring($datetime, 7,2)"/>
        </xsl:variable>
        <xsl:variable name="time">
            <xsl:value-of select="substring($datetime, 9, 12)"/>
        </xsl:variable>
        <xsl:value-of select="$date"/><xsl:if test="not($time = '')">T<xsl:value-of select="substring($time,1,2)"/>:<xsl:value-of select="substring($time,3,2)"/>:<xsl:value-of select="substring($time,5,2)"/></xsl:if>
    </xsl:function>
    
    <!-- insert description here -->
    <xsl:template name="DateTime">
        <xsl:param name="date"/>
        <xsl:value-of select="foo:handleDate($date)"/>
    </xsl:template>
    
</xsl:stylesheet>