<xsl:stylesheet version="3.0" 
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/2005/xpath-functions"
                xmlns:foo="http://whatever"
                xmlns:hl7="urn:hl7-org:v2xml">
    <xsl:output method="text" encoding="UTF-8"/>
    
    <!--
         
         This template follows FHIR-Converter DataType/CX
         Some Logic was added, see Design Decisions Document
         TODO: add GUID where specified after solving complexity
         
    -->
    
    <!-- <xsl:import href="../DataTypes/HDUri.xsl"/>
    <xsl:import href="../Functions/Codes.xsl"/>
    <xsl:import href="../Functions/DateTime.xsl"/> -->
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/HDUri/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FHDUri%2Fread&amp;sv=1.0&amp;sig=316GytzNtW7iWj6OT0HACUzIycIwsjPb7haQJAjnbHA"/>
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/Codes/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A33%3A16.2635168Z&amp;sp=%2Fmaps%2FCodes%2Fread&amp;sv=1.0&amp;sig=vS2_6dmmAR4JkFPUChUGG_mrcoGCdYkYzOgv_mionJ4"/>
    <xsl:import href="https://prod-17.westus2.logic.azure.com/integrationAccounts/f3c4a4187d0449e9b8173913b0b91d90/maps/DateTime/contents/Value?api-version=2015-08-01-preview&amp;se=2022-08-15T22%3A34%3A50.6784140Z&amp;sp=%2Fmaps%2FDateTime%2Fread&amp;sv=1.0&amp;sig=zdNLdR9Woqso07vIAMZ5BmbCoXkKvgmZIYlUVZ2zwv0"/>
    
    <xsl:template name="CX">
        <xsl:param name="curr"/>
        <map>
            <string key="value">
                <xsl:value-of select="$curr/hl7:CX.1"/>
            </string>
            <map key="type">
                <array key="coding">
                    <map>
                        <string key="code">
                            <xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="'CodeSystem/IDType'"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CX.5"/>
                                <xsl:with-param name="whichParam" select="'code'"/>
                            </xsl:call-template>
                        </string>
                        <string key="system">
                            <xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="'CodeSystem/IDType'"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CX.5"/>
                                <xsl:with-param name="whichParam" select="'system'"/>
                            </xsl:call-template>
                        </string>
                        <string key="display">
                            <xsl:call-template name="codeInfo">
                                <xsl:with-param name="systemParam" select="'CodeSystem/IDType'"/>
                                <xsl:with-param name="codeParam" select="$curr/hl7:CX.5"/>
                                <xsl:with-param name="whichParam" select="'display'"/>
                            </xsl:call-template>
                        </string>
                    </map>
                </array>
            </map>
            <xsl:if test="$curr/hl7:CX.4">
                <xsl:call-template name="HDUri">
                    <xsl:with-param name="curr" select="./hl7:CX.4"/>
                </xsl:call-template>
            </xsl:if>
            <xsl:if test="$curr/hl7:CX.4/hl7:HD.1 
                and $curr/hl7:CX.4/hl7:HD.1 != '' 
                and $curr/hl7:CX.4/hl7:HD.2
                and $curr/hl7:CX.4/hl7:HD.2 != ''
                and $curr/hl7:CX.4/hl7:HD.3
                and $curr/hl7:CX.4/hl7:HD.3 != ''"> 
                <map key="assigner"> 
                    <string key="reference">Organization/<xsl:call-template name="GetUUID">
                            <xsl:with-param name="curr" select="./hl7:CX.4"/>
                        </xsl:call-template></string>
                </map>
            </xsl:if>
            <xsl:if test="$curr/hl7:CX.7
                and $curr/hl7:CX.8">
                <map key="period">
                    <string key="start">
                        <xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:CX.7"/>
                        </xsl:call-template></string>
                    <string key="end"><xsl:call-template name="DateTime">
                            <xsl:with-param name="date" select="$curr/hl7:CX.8"/>
                        </xsl:call-template></string>
                </map>
            </xsl:if>
        </map>
    </xsl:template>
</xsl:stylesheet>