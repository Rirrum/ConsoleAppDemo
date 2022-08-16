<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         Follows DataType/CWECode from FHIR Converter
         CWE_internal logic left out - not necessary for PID.
         May have to implement later - assuming this is for custom
         gender codes
         
    -->
    
    <!-- <xsl:import href="../Functions/Codes.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    
    <xsl:template name="CWECode">
        <xsl:param name="curr"/>
        <xsl:param name="mapping"/>
        <xsl:if test="$mapping">
            <xsl:if test="$curr/hl7:CWE.1">
                <xsl:call-template name="codeInfo">
                    <xsl:with-param name="systemParam" select="$mapping"/>
                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.1"/>
                    <xsl:with-param name="whichParam" select="'code'"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$curr/hl7:CWE.4 and not($curr/hl7:CWE.1)">
                <xsl:call-template name="codeInfo">
                    <xsl:with-param name="systemParam" select="$mapping"/>
                    <xsl:with-param name="codeParam" select="$curr/hl7:CWE.4"/>
                    <xsl:with-param name="whichParam" select="'code'"/>
                </xsl:call-template> 
            </xsl:if>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>