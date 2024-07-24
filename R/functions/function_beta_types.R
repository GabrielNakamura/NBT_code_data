#' Calculation of directional beta diversity based on Baselga's beta decomposition (turnover)
#'
#' @param presab a presence/absence matrix with species in columns and "communities" in rows
#' @param names.countries a character vector with country names. Ideally the names must be equal to the ones in the rows of presab matrix
#'
#' @return A data frame with two columns containing turnover values for native and types 
#' @export
#'
#' @examples
beta_types <- 
  function(presab, names.countries){
    # calculating components of beta
    
    beta_core_all <- betapart::betapart.core(presab)
    
    # splitting shared and not shared components of beta
    m_all_notshare <- 
      lapply(names.countries, function(x){
        row_country <- grep(pattern = gsub("\\s*\\([^\\)]+\\)", "", x), rownames(beta_core_all$not.shared))
        column_country <- grep(pattern = gsub("\\s*\\([^\\)]+\\)", "", x), rownames(beta_core_all$not.shared))
        beta_core_all$not.shared[row_country, column_country]
      })
    m_all_share <- 
      lapply(names.countries, function(x){
        row_country <- grep(pattern = gsub("\\s*\\([^\\)]+\\)", "", x), rownames(beta_core_all$shared))
        column_country <- grep(pattern = gsub("\\s*\\([^\\)]+\\)", "", x), rownames(beta_core_all$shared))
        beta_core_all$shared[row_country, column_country]
      })
    
    # calculating native and holotype portions
    native_all <- 
      lapply(1:length(m_all_notshare), function(x){
        if(!is.matrix(m_all_notshare[[x]]) | length(m_all_notshare[[x]]) == 0){
          NA
        } else{
          # m_all_notshare[[x]][2, 1] / (m_all_share[[x]][1, 1] + m_all_notshare[[x]][2, 1])
          m_all_notshare[[x]][2, 1] / (m_all_share[[x]][2, 1] + m_all_notshare[[x]][2, 1])
        }
      }) # native - underrepresentation)
    
    type_all <- 
      lapply(1:length(m_all_notshare), function(x){
        if(!is.matrix(m_all_notshare[[x]]) | length(m_all_notshare[[x]]) == 0){
          NA
        } else{
          if(m_all_notshare[[x]][1, 2] == 0){
            0
          } else{
            m_all_notshare[[x]][1, 2] / (m_all_share[[x]][2, 1] + m_all_notshare[[x]][1, 2])
          }
          # m_all_notshare[[x]][1, 2] / (m_all_share[[x]][1, 1] + m_all_notshare[[x]][1, 2])
          # m_all_notshare[[3]][1, 2] / (m_all_share[[3]][2, 1] + m_all_notshare[[3]][1, 2])
        }
      })
    
    # joining all in a df
    df_native_beta <- do.call(rbind, native_all)
    df_type_beta <- do.call(rbind, type_all)
    df_all_beta <- data.frame(countries = names.countries, 
                              native.beta = df_native_beta, 
                              type.beta = df_type_beta)
    
    return(df_all_beta)
  }
